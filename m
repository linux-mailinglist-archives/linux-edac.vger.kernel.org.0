Return-Path: <linux-edac+bounces-2066-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34B99DEC5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 08:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C431B284069
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2024 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB2198E9B;
	Tue, 15 Oct 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcJvtPtt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7918BBA2;
	Tue, 15 Oct 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975228; cv=fail; b=CIGxg6gl+7exjImu3nhPo4GuFhnZ7n+o94AJS+uZ6Cqa6TTGcRkpxI43F+yyBNayw1sShPa9wO9od4sSW6p6OIFMJGnr8qTgP8U9pnMXiDMEUkRt4Qj5uo9CS/h+9gb97WZJ7dNBYfLv/Z80OXgCiZSB92CEtMR4VtcNb6F9BgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975228; c=relaxed/simple;
	bh=j3USFEroM2DyFMU6Qiay6u0Gx0SOHO0Cq59DJ6avLD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SEHtWk++/WvK2IBKfxoeGQLvogNcA+bdMNo48SJJthYbnG5nTVjPlb95w3CpgntDx5dgd2F52r5d2m8NFrZqo1rNQfam7jO8QI7ANd93UpMsQR1MYf395/KoiJEhrwCYDPzwU7Eu/vS/r8UI9uGLwP6SWIUe6Nk2uTneIZUyHVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcJvtPtt; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728975226; x=1760511226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j3USFEroM2DyFMU6Qiay6u0Gx0SOHO0Cq59DJ6avLD4=;
  b=fcJvtPttwHPjmz5QLjnf1Nrl7ghTJ7yEjXXJrV7u1nk2ewAw08Jk3BnN
   NNW/xC5lvRVSID4bl+65g7wSUkvpR95QtYKDFteT7P7E9G8oMZucv/eMU
   dzynn52EFeaYx66bKVT7CY+bu5p9rWpeFNM1sVGsSWJRC07zvLpGNJqJp
   mlkiUaS55haAiUUOmMtGw73xC/hb9E8m0OjjmkvcdsTrO43KRnoCcu/3G
   Nu0PD3idD1RV2XNIPKAP8YMf6aIGUKO32nf0cy+FaR/6sLj9PMofUAmOh
   V9pcMsWEWI7tXnZn2kmpiFkqbTqglbpdg7av421I0kdg1eoID1/iQ4qVA
   A==;
X-CSE-ConnectionGUID: arW5mOUrTF6BfNSwPrsF9g==
X-CSE-MsgGUID: n7yhhYObS7GrsFSxtKUBxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38903129"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38903129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:53:45 -0700
X-CSE-ConnectionGUID: hFJw/rg7TTSUCd7vYl+jtA==
X-CSE-MsgGUID: 0Eair/klR+e1TxCPlXu9jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77412803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 23:53:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 23:53:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 23:53:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 23:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxAMM1yJiwReZvHTwlchfFKTrRcRoLvzSvxQOL0FME+liErzSkzzerEodYKDsGoNopWN8gk6C6PG9sebDzh9/drG2tnLo7LUacRTPXQrpFRSHIdq++eeGSnGxfdUMinM5dx6CPsmm8Y6k58Q7CtlBJ+EOso0TX1MW/G7jhPrTMDA1yY782GfnXeKcrS2oziB+B114A4cVMOoC5fs+kAusJQCf4T6GWn/LPrSDLZkdZXSibmWbMp70csGYzGFMEAYK32pTbSzWJjHUSvZ9/cj7wvha32Uqt7flRgaLacY6W0Im3UFn0f6gAJjlj1el8U8ifuTqydn1K3A76faQbSmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM2nkophHyTLgtVs0aIHcDsk/+0l8asvB+L8CwqIHoI=;
 b=unJInTvKB0YGmNByqVSb3KXh3bRaWL3fm8UcU94Sm0VDG2en9shHU/FbZI9Stsz/lkqMtUDRgaYoV2wcyhJhtxi0reTCf1qz04X7yc+COzOBItfktGxDN1EilyQGgvKOOMzQyXMp3x/yEG1RnoW6z6bYPr26yfe0SJjJUTfHqI9C+K5ZoTtIQN1DBetZrD/jbi8L2g+f3KqD5ENhwlAKB8mIlRpG1Qb6lBTL7B+ZvdtKRMXSiwgXlXw5HzZpX0fS2ovzivPE2oGEGo68htK9DviAQoqTCMORs3s8s+eNJD+hKwhS+Is1hVb5xjXqOWmITpbAKzzEsgF5k8xR88aDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6784.namprd11.prod.outlook.com (2603:10b6:806:24c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 06:53:41 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 06:53:41 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Topic: [PATCH v5 1/5] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Index: AQHbFC4gq0D4a7cjHUu601KFGBrzrLKHaUHw
Date: Tue, 15 Oct 2024 06:53:41 +0000
Message-ID: <CY8PR11MB713406B2C492D55428397AFA89452@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241001181617.604573-1-avadhut.naik@amd.com>
 <20241001181617.604573-2-avadhut.naik@amd.com>
In-Reply-To: <20241001181617.604573-2-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6784:EE_
x-ms-office365-filtering-correlation-id: a8b13087-38ee-443f-56c6-08dcece61aba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?omRyrZ6HCJEf1WJsSmvCQklglSUZVIizwia1iZ4muDZT5mRcMtsCR5XbcThi?=
 =?us-ascii?Q?29EkagLGpNt7I6EjdwVEOvcMohn9dIpg/eqMUY0KlkKOg3WOqerbgcoc/i+n?=
 =?us-ascii?Q?ixBhBjtkliG0SfKcETg3xIi289Hul6B+DCLldqjEjB7t9gwrkpjL/iUhz9Cq?=
 =?us-ascii?Q?Uq7vHyivVcCWIV405apDv3SERVZEUNwYffVjELbCYCcXie1kSs0ccnIOvX/L?=
 =?us-ascii?Q?kAAx5MfdwBYtAPhxxRlv+tAl0k574uWlpUyun9W8xoaJO1XeieEW+H2Ac/YZ?=
 =?us-ascii?Q?r2SCsq8TrMSaz9zxXN7gnLgAfz7dYPJQLESxBi5xlZF30telSLRIfE5Lkaax?=
 =?us-ascii?Q?i9j3jqDtGm7BmUT8uANoDl6yuVWGCfEg3c2Rj2rw0TTBlDcaJLzWaW0JfyHW?=
 =?us-ascii?Q?I7PDy5uHreVjCB9trkRBseMTRdF7NFu5C7bzT1/cb+7f9c0/Gn+NKqNrh5Q9?=
 =?us-ascii?Q?vKPmEms7a8/PV8CQmLOpnsVFIPkkSUUoK6fa8tYUnGe3OSU0hLk+gYasdrDk?=
 =?us-ascii?Q?lvJwL9uw0ldTRSaNotCfjhTXW4NT7F0JuplcAOX9CXlDv2RfkPfSqtgu5ZBN?=
 =?us-ascii?Q?cyBfiunO107aHBme+j0QlFpo/ZnxnFkTfsOVKrNvGzhPBsuWHvOnEwv20VC1?=
 =?us-ascii?Q?Dq4OYjUsW3fGuoxPipZoCOXI6BS0YM/gPtKsdjbe76M5I/S7UDIN3Hg04bbT?=
 =?us-ascii?Q?/+Li5TlOLdEOo1g4y+p/F/bucrunHw5IkPBeR5j68WEf3YWby2stTXk8dndU?=
 =?us-ascii?Q?qFlBdB3X4zTfdEPdXCqtybMxurH8QqcqupV31ZdApZvIunOOeZJqFwre/vMX?=
 =?us-ascii?Q?87czJTeJneyyG0s9BQ6sCy2Z0WwY9dJcjLtBROYinTXzttDFFTQJOP5GLMu9?=
 =?us-ascii?Q?ZMmgI4n2gWNJcVQ3OksrXvZ2/0BbBKlpHQDzemFVrAxC6Y9sw2TONZQvtZrv?=
 =?us-ascii?Q?7UWjwPq3tTdmdJie9eeumMvfDb/ZFDgP7ubrxTUw2s418sMiT1JNFzqiigfi?=
 =?us-ascii?Q?jHx1nWoc6az+lBXA7K+SxfwuXdEhutqwAu/x/A+m+EPZsUqf4DSp4DmMAKYm?=
 =?us-ascii?Q?MCO0G5b/+e3t0ea7EgG+fgFRm5Hbj+9dourHPkAWcxBy7PgcQOdVEAS3dQRf?=
 =?us-ascii?Q?MRMudPLRGRgAIqv1bB7JSxWZ2dx9w3lmGxrJ9pI/pkuDU+2oZpek7Yo+5G89?=
 =?us-ascii?Q?F/GPiMoQgdEv9eGTkqH+pla3mS3fM/Bv+dJAgYOeyQ5H2Hysd+NhaHmRGZ4V?=
 =?us-ascii?Q?5dT0BYOMeXU5npr1XDRnaWN0zbbp5U8sPDv/SkYeX0AObqrhrNRZnOfYRhEG?=
 =?us-ascii?Q?E3lC8azJcv3MyxWKzal+FzwIJKITw1Ki/JXniMXNxFMhmQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txD+sECV6N8a9kLPVD6Fk2lvGl+5bm3egVekCe46W2cWarLsF4X1qqDDd6gN?=
 =?us-ascii?Q?2RQyM2wAb6p7V8WzS+ljih+iJ1IFctsFgHDXhy2OXx4xRCesvyABJ/hIygUH?=
 =?us-ascii?Q?FFG+/5vVgJGrAhXKODAJ3msCgQ7sSFXmcUPF0nIVTAXM5qkT77uq5aMO2EVd?=
 =?us-ascii?Q?ffjhv1dRVfGCBUiOc0TitT6v7iNgyXB5EOGYvHCpDT9eshyKWJR2FyK2wtAA?=
 =?us-ascii?Q?fJHJ/fqwgBZcUJxk1nx+lqX0bWR2QpofS1msWOBKI+3weIplD17I5WRay9ZL?=
 =?us-ascii?Q?BuY94vhF/R5CXXrtRA0LNw5rFouPG60cILeuJjG3H8N+H1d+nUs8tO/kSYMx?=
 =?us-ascii?Q?uujTSeYHTRdYolMmVY/2CJtU6b+MduoX2i1oNiXZYYW2oygRLqtUKgkcueR3?=
 =?us-ascii?Q?g/VmOgILzuOcIzEAnUrI/x4YI/PUVL5lnQCAoyjjs0RxSnyFb3ttZneCtZcW?=
 =?us-ascii?Q?zjISCgW9KIlgCF7rYxk1++LF5OQvqCSre3ucp2fsClnRBrZ34jI0lT/xado7?=
 =?us-ascii?Q?XTb6ofA5RNOphhNfupESb28tzCxPSyyRd4DBQ7unx2uHpe1iQuAiRN4Tu/+r?=
 =?us-ascii?Q?jD1gmfsbwJ1PVYFToDEMjm6S5cKtpUobyMdC0C1b02Sik+LEi6k3yuTDg1tm?=
 =?us-ascii?Q?NOo0Gc6VwS3hKIk30QO4IHgIHF6EQogX7ASyIiE3cfp0LniiuiIl/C1hU3ir?=
 =?us-ascii?Q?RqV8sio/gLNN7+DJwtG7kAjMY9Z3OUCNxjbF4d5JsCL8IbpqEQxRj6nhBwRU?=
 =?us-ascii?Q?rpC3ZIY9i6H3TcLSjFnlGoXIWcdyXBrh41BFwNv8fC0WCRJL/zDvZVvc9+BX?=
 =?us-ascii?Q?/leJW33G100jpv0eqblJefwzQ6qSNgy2lfk5f8PZPZkTieCxvVZWCJXip17n?=
 =?us-ascii?Q?91SyCgs/4hk36KP+3iwTN7YWMbjDXMgEZ4wdtbS/CO32PpRwg1KC9HWGIiFT?=
 =?us-ascii?Q?pFWHeAJ/YDAISCS7aCNkIehjvXJuJboeyswTLEM12+tjijv266LnB8FlMctQ?=
 =?us-ascii?Q?nyH5NDNmxvZkw3VfJXXzO7eY8Iu57BZ/4aJOcC63vprYVC/3oFWGNbLkroLn?=
 =?us-ascii?Q?DSSeilb+0QU8D81p0dM9pJsiQ69S6/bGf3eY9Vf/HE3dbIOH2DxsbOikdC3T?=
 =?us-ascii?Q?gxcC+KdvukWwLbQj988nIs6OxOIhElBVAf1KX20gFiAx2smcM1NWx7zYyD7T?=
 =?us-ascii?Q?ZjDTO69xM6PT/D2yaOIji4zLyOotCoP2S2LckKlCFdDsB3U1TUlkUIp0OBk7?=
 =?us-ascii?Q?UDPV4VpImbhTK7gjkuijKk+i2tDWya4Ul24pv7Wdup/yBRD1djfb2dwTrkLY?=
 =?us-ascii?Q?oNeoW/58YZXZnPdaUSqas6KZT8rShMWxiTtG4UuFKsnSfDSVMFG1YqAU9nRZ?=
 =?us-ascii?Q?Twc7poe1hwGQ3ipzOnMBrnmfQGQNJ2xenNkY97ZOpUQYVLHRokdmqB0Qdrn3?=
 =?us-ascii?Q?2FEt7i5sn/NOW35SPLSJgH+j9V+/+nShW0htNWRA36sQRr8OgErMIWZ7kaNb?=
 =?us-ascii?Q?rBPrf+DSa3ZU0BRCGoCURHKix/7Hnu6j2dCK5fe+01HeZvuDHz7CAspBPZ8R?=
 =?us-ascii?Q?/FoYmsyZsJiHlgsoymOt+hnf25rLln7l05a6cpxg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b13087-38ee-443f-56c6-08dcece61aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 06:53:41.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7YkzjP4d5ArHYjOJCoqPktYAgIrYCYaEEEX/iZ7uPxleNi+HZ2EmN1PBDTG2MeVQWRjzx/arx3FBO3fEjKA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h inde=
x
> 3b9970117a0f..3c86b838b541 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -187,6 +187,14 @@ enum mce_notifier_prios {
>  	MCE_PRIO_HIGHEST =3D MCE_PRIO_CEC
>  };
>=20
> +/**
> + * struct mce_hw_err - Hardware Error Record.
> + * @m:		Machine Check record.
> + */
> +struct mce_hw_err {
> +	struct mce m;

The word 'mce' isn't too long. IMHO using 'mce' instead of 'm' as
a variable name is more meaningful :-).

    struct mce mce;
=20
> [...]
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 2a938f429c4d..d9d1af7227ce 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> [...]
>=20
>  /* Do initial initialization of a struct mce */

s/mce/mce_hw_err/

> -void mce_prep_record(struct mce *m)
> +void mce_prep_record(struct mce_hw_err *err)
>  {
> +	struct mce *m =3D &err->m;
> +
> +	memset(err, 0, sizeof(struct mce_hw_err));
>  	mce_prep_record_common(m);
>  	mce_prep_record_per_cpu(smp_processor_id(), m);  } @@ -148,9
> +149,9 @@ void mce_prep_record(struct mce *m)  DEFINE_PER_CPU(struct
> mce, injectm);  EXPORT_PER_CPU_SYMBOL_GPL(injectm);
> [...]
>  static __always_inline int
> -__mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
> +__mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce=
 *final,

The 'final' parameter should also be a pointer to this_cpu_ptr(&hw_errs_see=
n).
So, it's the final value with an entire 'mce_hw_err' structure stored to=20
' hw_errs_seen ',  not just a 'mce' structure got stored in 'hw_errs_seen'.

So,
   __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs, struct mce=
_hw_err *final, ...

>  		unsigned long *toclear, unsigned long *valid_banks, int no_way_out,
>  		int *worst)
> [...]

