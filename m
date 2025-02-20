Return-Path: <linux-edac+bounces-3167-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB2A3CED1
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 02:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE0F189B0F8
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 01:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D07082E;
	Thu, 20 Feb 2025 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ai2sc3Ey"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224412B73;
	Thu, 20 Feb 2025 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015503; cv=fail; b=qPjfQk9DWwHQYvhhJ0UfOWBrReCox7AANlutyWqhP9R2Q73+p2a3LuJrFJePfLku0yx6GoB/oKQV/ebaC9edQlLung4u1d6i3NdDUWGBpT3wQ0+0Byh5i2boSWPwFryoTdeX0JbStGM2O5z471HDuNH1vxBCT0rqJbW913FBrZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015503; c=relaxed/simple;
	bh=CEq81e1IgcMHKxYep8pc+WLA+P+UmnjBlFVE0V4Al0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOQbiYv/VTjgeLeWoyF4sBVrKvd/LjiUtVAFFXmck2NoWoiHagngz0VZmENtzSA3aQnJr0aCCy19vrH/QEMroHXQHlJg73ftfSvsi9wOblG220Ds9rnJf5IYJ9AXd3CJG9wBjYCRO1TaTDClO6APYdRQVKBQn2597YpTwGRhd9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ai2sc3Ey; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740015502; x=1771551502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CEq81e1IgcMHKxYep8pc+WLA+P+UmnjBlFVE0V4Al0o=;
  b=ai2sc3Ey7gIWvgtVAOAoclKmkeFOfS4wzrf7nxFATPh2T3lzB5cZtWm7
   fzlXwXkJsQ9oB8JR/ulcDxzLNlH7Zk3uDkrDgJ7xvqkQgtMzMCaTi1wW9
   UpOEgGy1D6R/RwqK6p2ij4kPJakFfulpnfAL9KjKwo6bBsPmH8/0jlVMc
   pEq4Kq+No6g54VrDwUGuzHuK2pST7zbrSyDnLUlUjV4G9eIOJul54/tsV
   EPqJigKLSeRaOoSZ/seiTtJPvLd9Ilio4M35oBfTqNFffWRz+WbZLRVX5
   RIw1vgphvSzHHoew5DM54tTW2az6GPZCkjI7xz5fqPVDfZ5ptvWo8PN1b
   Q==;
X-CSE-ConnectionGUID: Kjnqd9FWTXiwy1fLZk/L8g==
X-CSE-MsgGUID: saTowhjsScC/FAL1qE7QDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63256580"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63256580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:38:22 -0800
X-CSE-ConnectionGUID: /MdQ8YJsQ2aXRDMZicc2lg==
X-CSE-MsgGUID: PRpxQLJ9SDiaknB9e/PwIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114623155"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:38:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:38:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:38:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:38:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nearIWIv/yd26qJMXRqRRPt6PCQlUTVQB92g+6PEhCVq2m9+95n5FcxYgJI2IWlWTTYsu6lL2sLzAEe3dGqxGVFmMZR1BQaxKM9JeVFMZ65WsqzlPCrFI5IdoidaofryQxCvYitFyMiyT5OIoVP2j/rehVkgfJPO8NJxbgQ/WB8GoAZDZhSceXXweUWZCx+p70Yt5isR1ISGc4DA8s1iUnzmSsxL2zgrabm73zwei3V2Uc+kLCfF7gMg30qRmRYy1iXR98poHnzKn27iTx6xXddq5opxxxZpNPYw5NkgqcU6daq0CiKwN6GoZKnaKkMsWa+1JYOBfveofRFZASSWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYbx22BlYrCOFo7p7ngSOyCnADqorzZgcC7lPz6wAvM=;
 b=N7qQCH+dy0wT+UO5GIPTQeWYVdoOsHK/mU/wqJMkCR6afKEQ8LEmgkge9JZhFd+ytiiZGOqTC4dMsmIhHKNFauvQ2B4guyfkselLmOiEui9rW/luppjJfUGLhT8URqrsULoOTyPL7enQxcwWjCVyDnqc4ZqQxSWF/Jkrt1izQeRt8ysGtfoQFyPTmBZQh2iRTg9zPYhxBRmacHthHCyidpqYH5GD2PNr1a5SQuHdyWs3YjBrjGAsgQ8Ztqz2XX4xLuX9xahcEkhnCnk0outinhOYj5+0VCDy+T0YpmsfE72Z+muwYy6OgrEUJV/wI9KSnzvEcWuGpDqsOfQros5AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 01:37:37 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Thu, 20 Feb 2025
 01:37:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Topic: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Index: AQHbfjlT9nBBe5Yi8UGLWXfjZPPcjrNMZ98AgAJptYCAAJ+JsA==
Date: Thu, 20 Feb 2025 01:37:37 +0000
Message-ID: <CY8PR11MB7134DA72B48006B403A6516D89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
 <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219155745.GB337534@yaz-khff2.amd.com>
In-Reply-To: <20250219155745.GB337534@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: d3300ce5-f864-4b63-4bbf-08dd514f2858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?epLQOgy2MGTBafvPu9rXo5RPq7RABtVlvio0ymSYNkN3PYYe2jpzy+0Qj5if?=
 =?us-ascii?Q?GQekIsSSNEMND88tK8QriiJOJd22dCmj1K1RP1yjf++JrqXo3BJKWqJR1I7+?=
 =?us-ascii?Q?eOM9F9Q7lGlHfdQp5aTXsWbMn9Xlq4IYG9atxuMoDZXor/wWAkUyavVy93qp?=
 =?us-ascii?Q?Zvq0pkXC88rH/RtUPd+eRwpvxsVHFnirsiCj16riOxxpTkF3g/sUyY6cCXC3?=
 =?us-ascii?Q?BWiCXCFaRLYYbKiIN+DIa5SSHIN1fwDsebIWCiV8JXdZSTmYM1oOVTQYiiSU?=
 =?us-ascii?Q?Vcgoa+yRwEvbXOhP6btb2cOGkLklI8va5AaN5EnLKvhCXVFkSEeQB3J6btM9?=
 =?us-ascii?Q?ofJUxra/LA9+/45rDNpBY6WykzpzmT6SU937jUfcudOEqEYs35KbUW+g0eA6?=
 =?us-ascii?Q?UJDatzox+Ig3MC7Tx5UAeavbgqmmKw+17oZdYnw5AhKoi+Rp3W/WhE78082i?=
 =?us-ascii?Q?FYnnfadooYT2FkgGNWlgbhzDm9rqVSFdCjVROwQdKvTmL5Uwp6CVJyPlNG7j?=
 =?us-ascii?Q?DyWGayowFgsOv0Nm2j6cRgOU5iN1pdqmXrk+SxPGVFGmK/v3L3Wovcm6yXIA?=
 =?us-ascii?Q?KDdhXKJLz2x3PTaXi/un4bU0uNmEZQL8W/pLM+ltG1qYiGlzlGQElhXj/Qh8?=
 =?us-ascii?Q?OmPWw+GVYD95ibJfkL7KUWFLfd+9/Gfmg3uxP2YiCWkF9WdsggyMuXoiWu7o?=
 =?us-ascii?Q?ijqWtlRfYCjT1XQ53BMCnGU4rpNkLrJs5jnvGSeo2ejt36KgmyfCN8HFg3kH?=
 =?us-ascii?Q?69D3IVpTcLvOG0darB0jmp5WO6h0U3TCU/H369QgfV7Qn5drxquIkDqCIMZT?=
 =?us-ascii?Q?IEIbojiNc38eyDjQsU+FQC0bCf0kLHJl2fSX3GJDDrMJCq7PS6j9UyPhzWkb?=
 =?us-ascii?Q?t6w0rtiY/xqGuMW9FKgeLh+oMtRy3cg1rdLk+TDi7SENShI0/ugYO3a+YIp4?=
 =?us-ascii?Q?KZBRclFDAVOxBowAGLlngrqmWLqaCgY4e3oqKiVTpocXRPulqTMlxgBDKfZd?=
 =?us-ascii?Q?3+yM0R1TR2oqNJc/F2NnoSoToTZuxpQjH2jPWFh9HbIhQYKjIWTzj46b1T6X?=
 =?us-ascii?Q?ZiqeCNieTYXHm40bmuIvK+N1uAaJlFHLMHjuU9jSowgNnnpVTXsjdaby0M1a?=
 =?us-ascii?Q?l9w+T+n9WdYGC5jZgE6CdZNyemRggqcyLV+85XWOl/PY+wpOtFgBZfRaw+TJ?=
 =?us-ascii?Q?fMWLxFnXPar8HCd3nWata2p96jqoPipzZ4Ja3uuCem/R+6FIdZJuL8OUc7tO?=
 =?us-ascii?Q?XApTOA15Xiidtzew+iushaU/W+ZJvJVGUDiHP+fJYlDxWhtx6dVWYRPU5B3R?=
 =?us-ascii?Q?WtXh4oycfWSeJoacm/rr7X/EcE3qiWx/3ZjDws5ccv/xPpxizj08dyfgZZiz?=
 =?us-ascii?Q?5H1TlzWUHtows1+aw8m1VRGjqUlw+aTwmxYleERaAa5pC6AlkrZQ4PrQyuXN?=
 =?us-ascii?Q?+htGIQy2Bu04lLS/No/97YokyJaARTaL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JW1eOxM7B7o0ZXE39vkVd/dgLqAgfHS6NQda5ziuzAASK+oMawAVHYv2qcQs?=
 =?us-ascii?Q?7twMed7nG/v+xvQX03DItNx1wTtfMPJloDk8mSLUZWJH+sKRFGCuNPyzl7AO?=
 =?us-ascii?Q?OdEMLHwL9SmPZQhs50xo3mh0YeDvO3lpgNapCr9M8i2mJ51mf53nFZx5lQwH?=
 =?us-ascii?Q?SfyF2zoBT3vAIxLqlfFIZkzkZhyAe+rZjjbJXbpVPQj0oO83WM7mU/G3mQgm?=
 =?us-ascii?Q?yfLrFYpALLDz8IvviQyDkEWAcFPKPM+SUpqX9r9J5wEFH2lmJazG1AfYqXxQ?=
 =?us-ascii?Q?NbOnxNiLjV91AHKbKlkYJRqhdu5TJ6O7w7VWiReGI2bqqMemlGO4m+bs9HxO?=
 =?us-ascii?Q?7bG+ggYc76EEzBGutaJKl/I4zeYEF+5kcOZ8tx2OT9prtEBd3munLPrmYN/N?=
 =?us-ascii?Q?71qPncfslkWiiQBjkvkonN2apP3pf/wbuXPoLHNMEy9krwX9UvdI7x7kBJ5W?=
 =?us-ascii?Q?viY1PeK6ZQOjkRjXRjYvoPdBAhYlwiw+KPLCoWdAT9KGsC7qXMg8aub9/Kb9?=
 =?us-ascii?Q?mrGePI7Y697PNtEHXVtxZvJjeG6ZoOAtGGRWkI6JgshfGYeYHHlfKmz261EA?=
 =?us-ascii?Q?IQYvmdNjvDhwssw6qYZujH5yBLlEhd/bobEkrlcyjl5ED2SwVbCmSFdudTvO?=
 =?us-ascii?Q?3WPBtK4sD03SxbyqjtYxltPGhCByAAT23JYCw5ccgj2OBko9Cl98H5uKKQB6?=
 =?us-ascii?Q?r+NXKEd+DR9CruyS7WxgXIMZFQndi4EhOl03CBjm3TH2zeDRXmD5vUSNmysk?=
 =?us-ascii?Q?zePBCP3Shi435d03o+W86L2m2jl0beU9YujVn2aYg6J8p3oC+M9NQoM5/4QR?=
 =?us-ascii?Q?inOVIOMNI/xfFA9Y1GXKm3XR4hqXMmXqDi302y4ryWqEbGau/h7DgeVebuQ3?=
 =?us-ascii?Q?loY2l04X9Cj/ag+NLlR1T9+lJcEs7xOgZdqCXocNndMgoE5ujxwPnTZlES4D?=
 =?us-ascii?Q?vU0q9xHl44DOHOYrzegC8b8e9uwn+wVV8wYjdmpZn/J8ZBjzP8ZgarCe20vA?=
 =?us-ascii?Q?a/q8RV7X1DL3Ydl+glCq3Zk82yXnQ5xada37S9WX0HX90pkB7q+jr7qVNjtU?=
 =?us-ascii?Q?YZi2CrQu3p5A5BX5L5JAEqwquEwXQxPCsZTY+D2uK9FtI5U1iKSQvt3gOZsf?=
 =?us-ascii?Q?tlaDi0x1d1v68UrWLFdCVr0gTzWzjYn9fu9T4CHZDh80cLB6K60ZcDxoqoxi?=
 =?us-ascii?Q?upwyv04/nXcxgzLGcbY52ASFuwHOSFWwQat5NeOKIWtYLYZDI9Vu9qOmq2qG?=
 =?us-ascii?Q?cydqLsEk4GJiZYxluFVlTKkzAhZdnEVFaF09pRAX7hN5dpYk2nWrUJlJI+S4?=
 =?us-ascii?Q?n2hJEDEwqTu5TZrlKbIcO43uS+X+u/pXWxME9SFPHo+ztfJNIe8pag+A5K/R?=
 =?us-ascii?Q?X1ZYOpfxykyte8Gwm3CsdVZS1bsSKeoJUqnbhZXEhgHPtp5CfmDbUodWThU0?=
 =?us-ascii?Q?KbSow+pZKeULhXeHGZLIuMo6mnwiJCm1XVr0uyFh5WkIIAHW2MOOEVJEghAR?=
 =?us-ascii?Q?fuGlE7AC7t/lbQzmDthA++tSBoz009pe0wmojn54MA2iwqJxtHjqeVd66cp+?=
 =?us-ascii?Q?hJDe37OPhzb8kl7K2yokrD5H/7/LVLgnyD5DMENc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3300ce5-f864-4b63-4bbf-08dd514f2858
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:37:37.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYMXRCF4n1clnSCuAJQRLA+OfODpX+qna5h0btFpufB/ledNIT8WZfJBygWt6JfX3xAFGB17S2qhUpSxeQ1HyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > > --- a/arch/x86/kernel/cpu/mce/core.c
> > > +++ b/arch/x86/kernel/cpu/mce/core.c
> > > [...]
> > > +/* Called only on the boot CPU. */
> > > +void cpu_mca_init(struct cpuinfo_x86 *c) {
> > > +	u64 cap;
> > > +
> > > +	if (!mce_available(c))
> > > +		return;
> > > +
> > > +	mce_flags.overflow_recov =3D
> > > cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> > > +	mce_flags.succor	 =3D
> > > cpu_feature_enabled(X86_FEATURE_SUCCOR);
> > > +	mce_flags.smca		 =3D
> > > cpu_feature_enabled(X86_FEATURE_SMCA);
> >
> > 1. Before this patch set, the above code was executed only if the follo=
wing
> >     condition was true. Do we still need this check?
> >
> >     if (c->x86_vendor =3D=3D X86_VENDOR_AMD || c->x86_vendor =3D=3D
> X86_VENDOR_HYGON)
> >     {
> >           The above code.
> >      }
>=20
> I don't think so. Feature checks should be independent of vendor, so the
> vendor checks are redundant.

Without the vendor check, the Intel CPUs will also run this code (which the=
y should
*NOT* ) and may mistakenly set those global AMD-specific flags, which may r=
esult in
Intel CPUs performing AMD-specific error handling during the machine check.

-Qiuxu

