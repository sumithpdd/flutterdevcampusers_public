import { Response } from "express";
import { db } from "./config/firebase";

type EntryType = {
  email: string;
  name: string;
  slackId: String;
  twitterhandle: String;
  linkedInhandle: String;
  githubuserid: String;
  assignment1link: String;
  assignment2link: String;
  assignment3link: String;
  country: String;
  flutterlevel: String;
  itexperience: String;
  whybootcamp: String;
  accepted: boolean;
};

type Request = {
  body: EntryType;
  params: {
    entryId: string;
    email: string;
  };
  query: { email: string };
};

const addEntry = async (req: Request, res: Response) => {
  const {
    email,
    name,
    slackId,
    twitterhandle,
    linkedInhandle,
    githubuserid,
    assignment1link,
    assignment2link,
    assignment3link,
    country,
    flutterlevel,
    itexperience,
    whybootcamp,
    accepted,
  } = req.body;
  try {
    const entry = db.collection("entries").doc();
    const entryObject = {
      id: entry.id,
      email: email,
      name: name,
      slackId: slackId,
      twitterhandle: twitterhandle,
      linkedInhandle: linkedInhandle,
      githubuserid: githubuserid,
      assignment1link: assignment1link,
      assignment2link: assignment2link,
      assignment3link: assignment3link,
      country: country,
      flutterlevel: flutterlevel,
      itexperience: itexperience,
      whybootcamp: whybootcamp,
      accepted: accepted,
    };

    await entry.set(entryObject);

    res.status(200).send({
      status: "success",
      message: "entry added successfully",
      data: entryObject,
    });
  } catch (error) {
    res.status(500).json(error.message);
  }
};

const getAllEntries = async (req: Request, res: Response) => {
  try {
    const allEntries: EntryType[] = [];
    const querySnapshot = await db.collection("entries").get();
    querySnapshot.forEach((doc: any) => allEntries.push(doc.data()));
    return res.status(200).json(allEntries);
  } catch (error) {
    return res.status(500).json(error.message);
  }
};
const getEntryByEmailParam = async (req: Request, res: Response) => {
  const {
    params: { email },
  } = req;
  return getEntryByemail(email, res);
};
const getEntryByEmailQueryString = async (req: Request, res: Response) => {
  const {
    query: { email },
  } = req;
  return getEntryByemail(email, res);
};
async function getEntryByemail(email: String, res: Response) {
  try {
    const allEntries: EntryType[] = [];
    email = email.toLowerCase();
    const snapshot = await db
      .collection("entries")
      .orderBy("email")
      .startAt(email)
      .endAt(email + "\uf8ff")
      .get();

    if (snapshot.empty) {
      return res.status(200).json({ message: "No matching entries documents." });
    }
    snapshot.forEach((doc: any) => allEntries.push(doc.data()));

    return res.status(200).json(allEntries);
  } catch (error) {
    return res.status(500).json(error.message);
  }
}
const updateEntry = async (req: Request, res: Response) => {
  const {
    body: {
      name,
      email,
      slackId,
      twitterhandle,
      linkedInhandle,
      githubuserid,
      assignment1link,
      assignment2link,
      assignment3link,
      country,
      flutterlevel,
      itexperience,
      whybootcamp,
      accepted,
    },
    params: { entryId },
  } = req;

  try {
    const entry = db.collection("entries").doc(entryId);
    const currentData = (await entry.get()).data() || {};

    const entryObject = {
      id: currentData.id,
      email: email || currentData.email,
      name: name || currentData.name,
      slackId: slackId || currentData.slackId,
      twitterhandle: twitterhandle || currentData.twitterhandle,
      linkedInhandle: linkedInhandle || currentData.linkedInhandle,
      githubuserid: githubuserid || currentData.githubuserid,
      assignment1link: assignment1link || currentData.assignment1link,
      assignment2link: assignment2link || currentData.assignment2link,
      assignment3link: assignment3link || currentData.assignment3link,
      country: country || currentData.country,
      flutterlevel: flutterlevel || currentData.flutterlevel,
      itexperience: itexperience || currentData.name,
      whybootcamp: whybootcamp || currentData.itexperience,
      accepted: accepted || currentData.accepted,
    };

    await entry.set(entryObject).catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "entry updated successfully",
      data: entryObject,
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

const deleteEntry = async (req: Request, res: Response) => {
  const { entryId } = req.params;

  try {
    const entry = db.collection("entries").doc(entryId);

    await entry.delete().catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "entry deleted successfully",
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

export {
  addEntry,
  getAllEntries,
  updateEntry,
  deleteEntry,
  getEntryByEmailParam,
  getEntryByEmailQueryString,
};
