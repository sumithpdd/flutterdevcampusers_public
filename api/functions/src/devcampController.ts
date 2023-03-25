import { Response } from "express";
import { db } from "./config/firebase";

type DevCampUser = {
  email: string;
  name: string;
  profileImageUrl: String;
  phone: String;
  website: String;
  slackId: String;
  twitterhandle: String;
  linkedInhandle: String;
  githubuserid: String;
  assignment1link: String;
  assignment2link: String;
  assignment3link: String;
  address: Address;
  flutterlevel: String;
  itexperience: String;
  whybootcamp: String;
};
type Address = {
  country: string;
};

type Request = {
  body: DevCampUser;
  params: {
    devcampuserId: string;
    email: string;
    name: string;
  };
  query: { email: string; name: string };
};

const addDevCampUser = async (req: Request, res: Response) => {
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
    address,
    flutterlevel,
    itexperience,
    whybootcamp,
  } = req.body;
  try {
    const devcampuser = db.collection("devcampuser").doc();
    const devcampuserObject = {
      id: devcampuser.id,
      email: email,
      name: name,
      slackId: slackId,
      twitterhandle: twitterhandle,
      linkedInhandle: linkedInhandle,
      githubuserid: githubuserid,
      assignment1link: assignment1link,
      assignment2link: assignment2link,
      assignment3link: assignment3link,
      address: address,
      flutterlevel: flutterlevel,
      itexperience: itexperience,
      whybootcamp: whybootcamp,
    };

    await devcampuser.set(devcampuserObject);

    res.status(200).send({
      status: "success",
      message: "Devcampuser added successfully",
      data: devcampuserObject,
    });
  } catch (error) {
    res.status(500).json(error.message);
  }
};

const getAllDevCampUsers = async (req: Request, res: Response) => {
  try {
    const allDevCampUsers: DevCampUser[] = [];
    const querySnapshot = await db.collection("devcampusers").get();
    querySnapshot.forEach((doc: any) => allDevCampUsers.push(doc.data()));
    return res.status(200).json(allDevCampUsers);
  } catch (error) {
    return res.status(500).json(error.message);
  }
};
const getDevCampUserByNameParam = async (req: Request, res: Response) => {
  const {
    params: { name, email },
  } = req;
  if (name) {
    return getDevCampUserByName("name", name, res);
  }
  if (email) {
    return getDevCampUserByName("email", email, res);
  }
  return res.status(200).json({ message: "incorrect QS." });
};
const getDevCampUserByNameQueryString = async (req: Request, res: Response) => {
  const {
    query: { name, email },
  } = req;
  if (name) {
    return getDevCampUserByName("name", name, res);
  }
  if (email) {
    return getDevCampUserByName("email", email, res);
  }
  return res.status(200).json({ message: "incorrect QS." });
};

async function getDevCampUserByName(
  searchby: string,
  value: String,
  res: Response
) {
  try {
    const allDevCampUsers: DevCampUser[] = [];
    // name = name.toLowerCase();
    console.log("value : " + value);
    const snapshot = await db
      .collection("devcampusers")
      .orderBy(searchby)
      .startAt(value)
      .endAt(value + "\uf8ff")
      .get();

    if (snapshot.empty) {
      return res.status(200).json({ message: "No matching documents." });
    }
    snapshot.forEach((doc: any) => allDevCampUsers.push(doc.data()));

    return res.status(200).json(allDevCampUsers);
  } catch (error) {
    return res.status(500).json(error.message);
  }
}

const updateDevCampUser = async (req: Request, res: Response) => {
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
      address: { country: country },
      flutterlevel,
      itexperience,
      whybootcamp,
    },
    params: { devcampuserId },
  } = req;

  try {
    const devcampuser = db.collection("devcampusers").doc(devcampuserId);
    const currentData = (await devcampuser.get()).data() || {};

    const devcampuserObject = {
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
      address: {
        country: country || currentData.country,
      },
      flutterlevel: flutterlevel || currentData.flutterlevel,
      itexperience: itexperience || currentData.name,
      whybootcamp: whybootcamp || currentData.itexperience,
    };

    await devcampuser.set(devcampuserObject).catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "DevCampUser updated successfully",
      data: devcampuserObject,
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

const deleteDevCampUser = async (req: Request, res: Response) => {
  const { devcampuserId } = req.params;

  try {
    const devcampuser = db.collection("devcampusers").doc(devcampuserId);

    await devcampuser.delete().catch((error) => {
      return res.status(400).json({
        status: "error",
        message: error.message,
      });
    });

    return res.status(200).json({
      status: "success",
      message: "DevCampUser deleted successfully",
    });
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

export {
  addDevCampUser,
  getAllDevCampUsers,
  updateDevCampUser,
  deleteDevCampUser,
  getDevCampUserByNameParam,
  getDevCampUserByNameQueryString,
};
