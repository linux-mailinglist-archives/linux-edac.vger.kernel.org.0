Return-Path: <linux-edac+bounces-2118-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAB9A1B2F
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A528ACD0
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 06:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED31C232B;
	Thu, 17 Oct 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKZRZ42t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D81C2309;
	Thu, 17 Oct 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148318; cv=fail; b=A+kg3KuJSHu3Ho+mZbcsp5LE8jJsW2VM4OHydK6bk4NYw1C2k9b8nU8/X7qUYsMXorrg+3B5bY+loH+63G5HIqKmpxQwbIy47z+9uPN16LZhkouFW5I1eEijLLV3Cqr18MrM9hdjo+5qanjo5OTYXATK+HysjhYr3dgjKhbY2Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148318; c=relaxed/simple;
	bh=2K83JuXodc8aLkrXqMfa/kNj9Yf0GxW6xUDBKdz+vGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6ecVrAnWIzGn1zasHbZWgkktznNvvefX+nUeHP7/kIAuVUTToHaLWs1ggRqLAYwgMwmdz5m0/5jhuMT1tTTueQikLYNprCt6w5Zp1KDpOTegsy52+SPI3pk5fgzBMkGbUGkZT+tuA2ti1EYWWuwsisHaMatBwLcUt+jIdV6+6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKZRZ42t; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729148316; x=1760684316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2K83JuXodc8aLkrXqMfa/kNj9Yf0GxW6xUDBKdz+vGE=;
  b=eKZRZ42tYTiHCOjzEHzeSNJl2KBjyphascpJzIW5OX1vCboleTsnpUP+
   uWhtD5E2valyZCMnU/T202OA0wGMhWuNT3Q4rZ2Br31S87670fswhvMuC
   gPuc0tfs/axRNCmf0B6/WUCNFz1w0+FaBeJ5K7n//bnLN8eGwOU/2qYiJ
   erCvTezJgRWoJetGBgUDJqohh4nqxAVtan8n2kN0Bz3Z1unxsDqH+Ajud
   Zm59QVmfANPfG3j8KE6yhC6bz6dIqLPHzdSN3ZXdQH2R5/BFsXaIyJcmT
   Cxe9rvFFrK5ylxzbFMGrl3+yUWxAWg2iOfJMunD9gTfHmqTMT6vmWbNRN
   g==;
X-CSE-ConnectionGUID: U/BA4dc0T4SgZIzr+ZlTHA==
X-CSE-MsgGUID: X6cVyHLRTESjRgzALND6gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51164686"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51164686"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:58:35 -0700
X-CSE-ConnectionGUID: L+jt4HMOQoeNkId2zJQ/zA==
X-CSE-MsgGUID: zBwMwCumQwqdjZ4hSp4uoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="115889375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 23:58:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 23:58:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 23:58:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 23:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6+fH9itJWY2p4xVEaUVZ0EmMJDdsLUs5Mh7E+IhxC2HPW77TwAhptkXWU4bVVMhskb+sGabnAh9essr7U0StWQ33VyuSmV6+Kw9tKFohTVRmJfotNDHRdMlK7GJuY4KyGTswjxT1nZL1fgBprq7a9Uv1UpHn9SjZzNr7qxrtgPUkTl4qYHnlyH4y5pBtY0CggkO/6TfFem2ntMVFS5q5cJQ5H/31Wi3J1unBwIDaaYVX4P2LrPNpabr08VihFpDtrvkQyW2mCtVqXV3FxGC5vBN3GbX6OWVQElw+Huz9sQK5JPJeWspkmAd4n4ddk6TUwXmaoJXMvCLMEd+VBdmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvs1VoFzGL8gu8Oytybzxr21KSvUUOF7wiF+VV7+m80=;
 b=ZZQFfcwWJHjDG0VLkp0XPslwKIgX2M08DHxzYxXI6ZiHPnz/ZknnhG23XALmeV1JDWAsu54W+fJTldianDDSiBop+bOX4duBmj6Wz8xgGkOPGy7NtCrBqGNYEHVBFkTNpLb4HDIvQ0PCyw8uiP++ehBv37ngxUP0yEmThMSN28HYFnMRFshQGr8nQUPALKY37er8fPA2R5Tl3aHPDz/5J0HH4LaCiowhUmi28kH4LpyF/KSHe6X5Ej8OL/vB9WVYCSQtfjZDqgSU/Kke+QVRbrwSg1V4Wgn5vLUAxor1kchBA0ta/wbcGjopPpfbYN+WDBjCmAuqJxXcqR5hBxHyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 06:58:30 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 06:58:30 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Thread-Topic: [PATCH v6 2/5] tracing: Add __print_dynamic_array() helper
Thread-Index: AQHbH5ZikyBRI4wavEGOaeFd7CEx9bKKgy/g
Date: Thu, 17 Oct 2024 06:58:30 +0000
Message-ID: <CY8PR11MB7134B1AA1F13546D2B84728089472@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-3-avadhut.naik@amd.com>
In-Reply-To: <20241016064021.2773618-3-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CY8PR11MB7313:EE_
x-ms-office365-filtering-correlation-id: 246a44a0-9cec-49f6-aaef-08dcee791bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dJDrN2N0vxphxRlYo/6zzLwXs6X57V/Cg4b7kDbLH05ejFELgwBu/jvaxSWg?=
 =?us-ascii?Q?xpIsv8ooP5AkuU7tc4rbNYZ/18u1cOuYf4HyXyxJmQ3o1P7B4zjcXB7/Nuw7?=
 =?us-ascii?Q?zquIgaYXZHr/7ULShKnpbMmAeHhjIZRMFpr0sTTaPMDSC53o385B2qt+Bsmx?=
 =?us-ascii?Q?g06MEPp9gFSQ2dpEWQ9lnJI7ZGYpc4qFzIUv7MTofe/MAWi/CCX44gIpcmQK?=
 =?us-ascii?Q?uHZ2razQ7TPSrJYH2cWPStf2uZOW0MKKRwAm32yMjxogJnHgY01gY7yFtfMn?=
 =?us-ascii?Q?Dru+6qZANpx1/qgiN+B8kCBfQofTv8QruCikhBrMg/a1l9r6AoE3p7JRcVsk?=
 =?us-ascii?Q?xK3onJMJaVw/8FF11v5Wy63BYY+Np4t0jf+fNTWY8XbA98CLi/0xLNyHv/zl?=
 =?us-ascii?Q?jtQn4LuyrVGllJ1fidRIqZUGwHmqBQRAFv0CDsoYzKGs1VP0cT6gEdunpFqI?=
 =?us-ascii?Q?D+NbTo13aqDbsg0hle9zQZtyi1eCbJ+N6YDoY7DYrlhblb69N83H73RdP/QF?=
 =?us-ascii?Q?wKh6YGzJlxFKIvGnwB9jFXVavPZffSSwN7pXZrJKn/US94Z0xoHVdLl3IySk?=
 =?us-ascii?Q?Q7TwILU4mL8sgxbJp5qkeEAYGGn66pHcEAaYtWuP/k/4OmichlDFVBOENbTG?=
 =?us-ascii?Q?h0dKUPN3D1UQlzdDz7pr0Fv4orYy8PUN1W7BHEPGJFtwR1iKJ+LLt3Tuq1LU?=
 =?us-ascii?Q?HKVlQKdY5LTLVUnUmaD0nLMjcqqFcEnFHoXIhIP88pjBVUVMfVreGqe5ToHe?=
 =?us-ascii?Q?w/N6JGO0pCqZpnT/StekgO2lki1FQVp1hDmYrTH8v1v9DiRWKgI6AsmFVmnc?=
 =?us-ascii?Q?vxKB4vpZxRFh22Emn53WIiFxuMgYQ6MJcjm4CEsfxO5jt+FIrqXEaHMl8BV1?=
 =?us-ascii?Q?aq0gjsYsG3XSPIKQRUiYvh7qXZL1MjC/53Qxo7zEGmw8c7SA4XKQi2IUP4v9?=
 =?us-ascii?Q?pMeURkajFR8rUTLsKhaXvCJbuWJzmFeEhuETIu8LG4OomdspofEu0di6GH86?=
 =?us-ascii?Q?WLIpSW2muyGPU2wnk8CxsXVoMfCRwJXLSnU/9dICAdw5LlcktIz7zk3FVxsu?=
 =?us-ascii?Q?DlBvsrM9pvGewQ87ikCvFtgFlNkx38CzoM8hOw+e6MrwtMfYb+cI6bAHHjns?=
 =?us-ascii?Q?KQL+dPWeHQBxAjBBbCrL9MlAohPBv53qJiUIjse2s/RmmNkGRvc9W05vV+cA?=
 =?us-ascii?Q?xOurclh4P4NtWgyDVCOMoBtZV5DwHjts3Mg/mepNB9iw0S08Zya60vHOx593?=
 =?us-ascii?Q?3+QZW+Nchb/+864lzKeO2Me669h/BErreikwe5MquRSQkZEP99uLeziOzM46?=
 =?us-ascii?Q?saFpQAgtIkmBYduZr1o14OMhKKBan3SuhgHjRepQZJ6kxnKloFmIgw1HwsGh?=
 =?us-ascii?Q?9TjNTkk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+0Get2YjDUTDN5rbGcSVMRCDsMCfvUWvxdWOBt7FW8SocFvP/P24gfIcuLsj?=
 =?us-ascii?Q?mZ4WTfdUd4IUUCUy3CggRuoXf9Y28oXXKua3hOxBo2yE4TtAYqmNdn+0MMn0?=
 =?us-ascii?Q?BMTnBYXhVIvjAzaRloPMurAU6AeDO0NrGZsxqm1PrL+akNySNF8QitjISrtV?=
 =?us-ascii?Q?ZaL2qjRWYcMYvVmmGcGicRFMDwMj+9Pm6H9IYJSBiBA2OYkuwiQyv8acV2uE?=
 =?us-ascii?Q?MMIHx3yGxdjB3mwsgg8dHiJcqmGNKeBTB1ZIbej0P3JCKhP2csPOidc+nWlJ?=
 =?us-ascii?Q?wu48hCGWEmqIXC5Sbku4ekyRhc4smBROL/+WfFTXDFrUkvIcKjO3VSUmMAmD?=
 =?us-ascii?Q?IoQpuw351syrMRcDc922W30E1bLjkNDDD1PT24agbXg3Ih3VFf9xAeM3Ug98?=
 =?us-ascii?Q?IGMbUfpRIG87DLB4X1ROHa8PC9dNRIcaKtmxWsu473bTGxGOO6pRkmlQ9Pw2?=
 =?us-ascii?Q?9H3QHuHPlzr0qXMoeAR/GrOgozCHWAXGsXYx+IBkdw/+fcmpA490i9YFLNyE?=
 =?us-ascii?Q?v0soTS3tUSWNppnxJlMRgnogLvn+hSuP7fts1SNTOmr7sv6rOEIJGEfDEoTA?=
 =?us-ascii?Q?kNj2ZJCoZqAL6AmdycSIru/EtAtrMgoW9kVcNNgoxRrZbIZ2eokM6a3kCDOX?=
 =?us-ascii?Q?8Yw+2jvFK90oAjx3bmMB9zy2Lfppr/8Yw9L+t41P2P5BKpRJBCBMU/YNX9Pk?=
 =?us-ascii?Q?qc4ZzhxF/Eyvi0SQDChnNfcFEBkEEhBjmNTXBsEYv60WOOjDxZZa5RF2QaOP?=
 =?us-ascii?Q?y8IKkM74bksdYEGALyarL5h661xQ4D8K6L7wL0yUuM+VvRDIKvScQo8D/uJE?=
 =?us-ascii?Q?kxaVmxlnkWlEcNVfksp68MgtvzR5r6zEFJ3R1vUm9tY66GYIzyC5DCNuh3Ja?=
 =?us-ascii?Q?zk285YyHZeA8um7yU7oqZ/vtqnnr8WhWe6rXmE0harsfzbsiXtLnU6lvPFZk?=
 =?us-ascii?Q?vB1Ykyxh7lOIiClpfym7JWFOWhhTzrOCyT26kQupaPh/EilbqvDAq8UOl+oF?=
 =?us-ascii?Q?uf58ltOjsItYpWBwIWGFPkUTh2RUiCFuPRgDBSbJ7stZwtw3Ckw6uv1dQjCC?=
 =?us-ascii?Q?mLnXbHVnwJG5QmCnd2GaFQ47FMD1gYuvdMyCUOXRFrGeKTWqvBONiPfyC8iO?=
 =?us-ascii?Q?qvfaQ5hBWVzA4Yn630cx8lmWjMRFoowuuENvqVgZpv2bKlXwPj2IqkPYRHZL?=
 =?us-ascii?Q?gCVk0UQ5V4/+DHDSyhNrDefrzkjsGJQant7U7jwb9M2v0hHHf5i0NQAcjH7Q?=
 =?us-ascii?Q?HNqNuaqJt8+IysTEyCsb1l++cdmkpAKVEixt1rhQ3bWKeP2Gi/hV4xrSUXXo?=
 =?us-ascii?Q?zokQiGXBCXZbUK72sCNcPu7wpjEQFlxkNifx1wCU2Rilt4v3dNiNIvWz1muA?=
 =?us-ascii?Q?FbMBP2v5SzNZ8vO+yBtPypO81bWlyzCpUz7c1bklYmTeR2culKS3yY8qTxov?=
 =?us-ascii?Q?7N/EC4VVeNFnYrYj7A2PAN7Bc7T/524h9Ga8AcLDsZHi1nLo10pbZ01L2dNW?=
 =?us-ascii?Q?yVcFD9/gzCjDCzmONA9zdg8siPdEoUraCmLjLfOMuFS4O0FK093Vm2G2mSBl?=
 =?us-ascii?Q?kEm/6nTHiGCRhZrsEZbh+0M5KhtFpPQoAyA7tY9M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a44a0-9cec-49f6-aaef-08dcee791bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 06:58:30.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLKK8eWDF+QVSVRnOr9XnmIJGKP6HKiLPqsHx2xPtS7fc0I1aMjhnHbrTukaeDhTn3TuYnNfrdIWKArwthE4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> diff --git a/include/trace/stages/stage3_trace_output.h
> b/include/trace/stages/stage3_trace_output.h
> index c1fb1355d309..8e3215093e1f 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -119,6 +119,14 @@
>  		trace_print_array_seq(p, array, count, el_size);	\
>  	})
>=20
> +#undef __print_dynamic_array
> +#define __print_dynamic_array(array, el_size)				\
> +	({								\
> +		__print_array(__get_dynamic_array(array),		\
> +			      __get_dynamic_array_len(array) / el_size,	\
> +			      el_size);					\
> +	})
> +

When running the check below:=20

    ${LINUX}/scripts/checkpatch.pl --strict  <this patch>=20

it complains:

    CHECK: Macro argument 'el_size' may be better as '(el_size)' to avoid p=
recedence issues
    #36: FILE: include/trace/stages/stage3_trace_output.h:123:
    +#define __print_dynamic_array(array, el_size)                         =
 \
    +       ({                                                             =
 \
    +               __print_array(__get_dynamic_array(array),              =
 \
    +                             __get_dynamic_array_len(array) / el_size,=
 \
    +                             el_size);                                =
 \
    +       })

-Qiuxu
> [...]

