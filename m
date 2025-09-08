Return-Path: <linux-edac+bounces-4761-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE0B4954E
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 18:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C341884FD9
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB0307AD7;
	Mon,  8 Sep 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdY2oRr3"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AE53A7;
	Mon,  8 Sep 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349073; cv=fail; b=CX87SFQyTqTb4ZxaAApFeT5MfcS8glnQNlPV3vj0xMscNnhWe2Meac90nweJPRVlhRTPRXAQpqcmLXYdq8iytgOdlHbISNFxwLh9WV6B1sND4A0A9vDXpwGvfLtZXjTFyKgRXPpPogPtvglou4MIHzawXd0szwbk3dSwbAaJ48k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349073; c=relaxed/simple;
	bh=0TZQOW27He12XPNZAaeuE7Afre6aC8jBvbkBxbR9r+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujg6yK9gvGhzcZQq2W0fip51j7WcHAAkb0/kxb/rFJFcbX5+b0GZtGhz1Q3ff4hEAlqrm6OSxmbHkPppMMMBjjQqOMBP3agZuu+ai4KUKc5Dwr46lPEJZzf7o+NfA4DPhQ/IFR6iS929WmoLJKvnG/vwmbqy00NnHOCd922DFCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdY2oRr3; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHdN8RECtgh2BWYqDz92MVmOqXxSIcKDT2eaN6dPplrp0g9XGKOH743c4fstloK1i2Q1lm0KxArTTnVgiwIxHSO2STecVPUBRcM6v5vyHp7WyEWho5S4eyawLgyYDGHwJ/Ege4M/OCdaiP6MHE2FFfD2aAHXzBqJ3FdN9kg9Uam8Rw2T2GH5JpSADENB5/H94Y2MlUBhaipnn6uVUA0bhLr2Uzrr0hxMOYlalx0oGSpvsSHL7TYo4H3ynlUxQo3djRSDI/8SEfzh89lOxRCR9VLjqfZY8v2bJ4OuccI6tNJskf22OqtMn8tlWpEELY5A5K+NAcTPXajBlxtUobPvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TZQOW27He12XPNZAaeuE7Afre6aC8jBvbkBxbR9r+Q=;
 b=jtURyX7BfR3DrG40jtJO9yO5Fqp0OfYG56ly1eIYm0dvCM0vXStZtpv5TEk/mxxrc39pZTivbDVkmwjo+m0BCSXxu220b8U+ySnCuzA8RBoFiXBjbkjGEJNLJRuly395S20X99Nxo4F7W8BULE3i266gDMIHa8kavXi06IlcNEuB6qqOLI+WbrxOIWI6NuDbUtGZWwRlkslxDKqJF4I6rh/Fn4GrI3YZfehl8Xd9xckdHPj+7eudLp9AQPxz2yOvmsOKzBLNgsnmnVqaI7Lmk1BwaU8zYn4ws4gdmencirG4J4GjmfIWvVCHCUeo4lqf48sfHtdEAtHSHjBzKEuXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TZQOW27He12XPNZAaeuE7Afre6aC8jBvbkBxbR9r+Q=;
 b=cdY2oRr3hW595IOLVSLI0lInOBfZwzOabVCwh7AuaxQM4kdt5sBa+xUpyhp2FfXLz3EPVY4aT9uiz5AFi7r8WOJdnVhC9ja5HtJ/b/2Fxk1HW4bVZZtAgekqOrnq0cMybcd2i9zNF/Qu/o/NBZl9TGUEFRYdF8mQVOjqxJHAybk=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:31:05 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 16:31:04 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "git (AMD-Xilinx)" <git@amd.com>, "ptsm@linux.microsoft.com"
	<ptsm@linux.microsoft.com>, "srivatsa@csail.mit.edu"
	<srivatsa@csail.mit.edu>, "shubhrajyoti.datta@gmail.com"
	<shubhrajyoti.datta@gmail.com>, "Datta, Shubhrajyoti"
	<shubhrajyoti.datta@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [PATCH v9 1/5] cdx: Split mcdi.h and reorganize headers
Thread-Topic: [PATCH v9 1/5] cdx: Split mcdi.h and reorganize headers
Thread-Index: AQHcILfHorbN6/kVaECE5en6JW1+QbSJeg3A
Date: Mon, 8 Sep 2025 16:31:04 +0000
Message-ID:
 <BL1PR12MB53331B36CE94649FC17140C59D0CA@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
 <20250908115649.22903-2-shubhrajyoti.datta@amd.com>
In-Reply-To: <20250908115649.22903-2-shubhrajyoti.datta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=bd5ff838-eb97-4f41-84aa-7561673c15ad;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-09-08T16:29:43Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|IA1PR12MB6116:EE_
x-ms-office365-filtering-correlation-id: b9413c20-1b52-4a2d-c600-08ddeef51b35
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qj5pYcOFx4IfGUSvYuIztAVi+H3VGnQTcoya2FpPyPtRIXHTi6gjG3kENXOy?=
 =?us-ascii?Q?90OZfLO/maEv5Fhhuco5oDktKrfqARK8jIMOPqwTN0EMbzWwVQS/xTfKVyB1?=
 =?us-ascii?Q?LL7H8oyNbnCqd/lajW6SNvkbVtgAni1ByhjqDxB4aYheobeAku5+OX1rK3c1?=
 =?us-ascii?Q?9wRIp8EyAca8Si3JRcqIIEJCY9fY90MYcDxe8+06sN55t3QwMnMfB+is5nDU?=
 =?us-ascii?Q?d7y6mDu+LjydXNe7gCZRiecwn5Syu8Q2oBwQM8cv8ZmFBJf6Rzc6SEJL+CN6?=
 =?us-ascii?Q?WkFVGQzLox8ruFOqwZXMupr0taCP+tcXCxruk9dK4eqpGHnsH8oUp2whUtm0?=
 =?us-ascii?Q?VFSoVPQnaLgCe5hqR6zwt6n0huOp1fa4yxLi/lRGX3AibmsJWsLKnQjJ1vks?=
 =?us-ascii?Q?LEcDxMh3T0RcWO+DAVKia8LIlxE02ibunpsaUCOQRHynEU45/stHHvsZXlFN?=
 =?us-ascii?Q?F7L5eWREXsPSI6g1CemfCCXuoipeRs1utSqJ1GIpwIfBOzjH02ibWNHNOkBR?=
 =?us-ascii?Q?aBl12w1CplMjUgecZLZsPfVqSOyYb19Tqkg1IkIGg8QAJTd8raEJmNqC1AUe?=
 =?us-ascii?Q?IIU4hzPadxuayZ6faTqYsIl+gLZBcMKeQO7sP2ViQYutHQ1NqZoyjEc3HKY9?=
 =?us-ascii?Q?rxh/euRpMsmBywae6jrdjgTKXm7AF+xGiuIue9X7GdYXreb0TeDer1TU59SC?=
 =?us-ascii?Q?QN6vXEV/0GVlUsVm7QfTSDxrmT8Mo8XSOZTdLdaGvIUvPyYgwFysaKrGoFoH?=
 =?us-ascii?Q?OWQVYJt6Q5zfcwoeqa/KtwCUbQ3kbhjQ9eUcjZ3j7/vLnN5QTvUhTLnah1bf?=
 =?us-ascii?Q?jSPqZlvnKwuAWV6dn0Vu0+9Bg/e3QHq/RxHsNPJQMMZQOPTg+aIEORJ27g8Y?=
 =?us-ascii?Q?yPoiO17qgyY5xYOcGBIk4oMggGlZSe4yDbke8zpJfgqi7zBBQmZFvuCdt28N?=
 =?us-ascii?Q?iGeyoB8CuSXkAs2UVzdunHi5zuhcOur5rdtOZluraq8xzjBxQhEhTlukqcDW?=
 =?us-ascii?Q?LcI2aJcdV2ZOSGdw7lXOsbqIVADZXrzV0cfRyQWQjqcvbNH85mXIOreYfV+H?=
 =?us-ascii?Q?aHbi9qj41gsT3ynTF0ukQ531IG9Kapi5ccv5i9CJpB2WmFh8XI+Ab3Qc4Jev?=
 =?us-ascii?Q?hN58VC/WCB+n8P1E3/ZfGX4tHXqLdj9lTyVo22mNtzK/DWMiKRfmmZw9Cj7O?=
 =?us-ascii?Q?jYBuemqc6hpLDyVqxLnIswj1WjpfFsqeN1hnKW0HN2g71UQ9IhhwigtLKjdO?=
 =?us-ascii?Q?xgYFiKY9GIXwNdPcwGajYzEnS0JkngrGl1Rs6PGRuLt+yBvNvix6IXys1G5F?=
 =?us-ascii?Q?9bx82lvS+dXkhz0nflmuQBXt/reOws8xM2jL/uDNIfJ9DlvQnT3VbTsVo1kh?=
 =?us-ascii?Q?fiku+ylCnN2IOo35CVLBrYA+5DhUJYmwrLB8Uan3yKVIw/atB1zF/XTc+MxX?=
 =?us-ascii?Q?GU1XftNRcvD77ap1ntbsy2LLh0EzAWEakHC5Cnry+/w7cVfgFT/6QQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I+0+uWH2XheiQZoRIyLEmdbuyyq4PA7hZmnoM3Ca2KGGLjM04Dy8hb3w0qyF?=
 =?us-ascii?Q?yogSrksfqrZUzLWmT/5N6P5Mo41gLk9LExD2s0zhFy241FNd16dq7+LIZhw/?=
 =?us-ascii?Q?bhkPv+QihteQwCO1wH/NZ4v8SLZBPunnwNqHPH+628joAB2xwUvNfPR1znAs?=
 =?us-ascii?Q?ap6UZApV3DFlagLBSSu4rbPiFiYyC39GHromegFyYGHj07qkMSHqsrfw0Llf?=
 =?us-ascii?Q?3ZQ8Pa+sMNka1IjQu/YDhu+5k7B1pLxEvCw2dYtQY/Yn5PRbpG9UGFdWyncg?=
 =?us-ascii?Q?FvBU2DJWkrEr5Euz8ClSFD7ZjS84SRvSz7gbn/738ztZzwFyjZeKyrlpHzz1?=
 =?us-ascii?Q?RD6sfzLt5to45vx/gm5R5/bINVow37ul99pCUpevzm9EbNqeX/SGsZtSE/6b?=
 =?us-ascii?Q?hBFucyAcfHGjRys4Z68qhulYDe1cPAYHbC3hfvTCgKCHIhTVVrMOsuKJZgzW?=
 =?us-ascii?Q?doZDeYtv+F+iK0dSaFR5EJmaWsy+c063S5H7oHzjRRJwrd1ACTtpXt0jMs2P?=
 =?us-ascii?Q?KLMTZZljdD62Qtwv9osg9bglrJMj+yHFcfJuMCecAUiSnL2GEQQoRPm82tlE?=
 =?us-ascii?Q?qzO6oF33DRH1/5dtQad4urDwqfSA5oDmpI4ALSQYe+0rACtatPT4Aog+haVq?=
 =?us-ascii?Q?WdAotYnKAa3yo/2IySjiR3YDJTdcQk+cYaNcvEsr7+jDjDJ/AZPD80hp4qfP?=
 =?us-ascii?Q?r13+KNxt4DPu1yuPlWHWvXNGIYYcVDWcM3qVLJrzmghJrEGsBlwrFhjcx4oR?=
 =?us-ascii?Q?GDSuupqzd6+rm1pEOM4pulcm3PJYtVnJ2Jm8Q8Qpxwh/Nss+FkwHSv3P5tbJ?=
 =?us-ascii?Q?2tEzXBAQwI8ZV7lEvcPs6CJT1ksb/zVsTOXhgtA6WHO2M+Tk4pTh/TGIA80M?=
 =?us-ascii?Q?4SWDPMblw4MODOFylhqzEHuutBfbp7LFDCLWg6WYE0wiGSNinnslKbgIVF0Q?=
 =?us-ascii?Q?KIDCHLiEZDoL71DkL/XelXsaPLuLEwGoFt9NFfypOfaIDscGI0BDunI4CMFN?=
 =?us-ascii?Q?ErSMfIBPppHfwOU/HCd14kWHQCCi4VqvH27Z355T5JXcR2917DXGIuczVgDr?=
 =?us-ascii?Q?UNIlLzvZsMkqjDM6duO+ABmpBk5PkJMiro/Lmg/RAucN4tqeWGWSgYePbk6D?=
 =?us-ascii?Q?CWPMDrywdG0/lBypfK/iHK6t3WBS/6jfTGJQJyZvpDVNCARVrsB5KZm6fcto?=
 =?us-ascii?Q?dg5f92D5HpIMrJZeRMkNlHYgb0lijrIo3W/3jKaY3iq2tKBtKVFZHP1FlPbq?=
 =?us-ascii?Q?TzMSUx2qkU2war66mPJCd4SRZ2/TRdPh2UBTN7aWHPkxqHU8Qzy9PPHM7UvZ?=
 =?us-ascii?Q?MyaAvQQXR9Ie7UX6hEmc4HFfNGSTyC7GaLOZN+OHxuwgAqubm2QjvTbpyQxB?=
 =?us-ascii?Q?fjrdGhMi6ZWanrmgzHMc75vWKv1ed3NQkIu0iXDk62n+XNeG4RDxwSLFBPPK?=
 =?us-ascii?Q?cwH0OYB4amWEmlu5Lmr6rNLJaVo9Or1K/BGAY1NHV3hyO8KkNMqHyd/Y5ZVo?=
 =?us-ascii?Q?bk3aAr38Gl8qx82zu0DLpPCvbTVei1R52pGqd+pLjWTMBHHutG1F09/C36Nh?=
 =?us-ascii?Q?E6CXAVluILBBoTrnApE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9413c20-1b52-4a2d-c600-08ddeef51b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 16:31:04.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ObisDZTnyaK3X6Nh7XrxH56rd77JXj9sb95sldtQOKr2ZGndP4GqP5tCnw8KsjB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116



> -----Original Message-----
> From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Sent: Monday, September 8, 2025 5:27 PM
> To: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> edac@vger.kernel.org
> Cc: git (AMD-Xilinx) <git@amd.com>; ptsm@linux.microsoft.com;
> srivatsa@csail.mit.edu; shubhrajyoti.datta@gmail.com; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Krzysztof Kozlowski <krzk@kernel.org>; Rob
> Herring <robh@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Borislav P=
etkov
> <bp@alien8.de>; Tony Luck <tony.luck@intel.com>; James Morse
> <james.morse@arm.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> Robert Richter <rric@kernel.org>; Gupta, Nipun <Nipun.Gupta@amd.com>;
> Agarwal, Nikhil <nikhil.agarwal@amd.com>
> Subject: [PATCH v9 1/5] cdx: Split mcdi.h and reorganize headers
>=20
> Move `bitfield.h` from the CDX controller directory to `include/linux/cdx=
` to make
> them accessible to other drivers.
>=20
> As part of this refactoring, `mcdi.h` has been split into two headers:
> - `mcdi.h`: retains interface-level declarations
> - `mcdid.h`: contains internal definitions and macros
>=20
> This is in preparation for VersalNET EDAC driver that relies on it.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

For the CDX related changes in series=20
Acked-by: Nikhil Agarwal <nikhil.agarwal@amd.com>


