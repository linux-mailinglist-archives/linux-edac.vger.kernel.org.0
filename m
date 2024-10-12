Return-Path: <linux-edac+bounces-2017-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA299B16E
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 09:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055FA1C2194C
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193913AA41;
	Sat, 12 Oct 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npO3lDjy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795512581;
	Sat, 12 Oct 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717230; cv=fail; b=mSaRwjerIyerydLAqni6ghnqZl1sdF+RZSPJJ9bo+cyKg/6+sHKIEVzCHmRAOXXqJORjgoxB4quJTAUWLqCUWJ20+7g4z1h0OuhPB+bSJ7wZOm3TskAkRbziXtood7ChMVZCcS8+SS2sdqJJl+9Ytqu+yA7Fgu5nVW7Dlv1vZN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717230; c=relaxed/simple;
	bh=nZpVIAdEV3b+0R11MjW6gdVBVAD9oKAkzaW3cepGUfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvoha3saRouEuzeYyUjxu/lTWcqhcGmtgqxvhnAVQg/KTRIR7OxhSxGDip/8iSEHeX1fi2hjcJ0MM0b8njhk16fQI0mokr1UduzI9rYsAmXdL2gMjUAYv5+BEnkCoSvEzYs6nYKIUVNYxsIHpNpdIcXpyUcUmwIYVT74F/Nz26w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npO3lDjy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728717229; x=1760253229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nZpVIAdEV3b+0R11MjW6gdVBVAD9oKAkzaW3cepGUfo=;
  b=npO3lDjyKFXrnsAMRwdJbcq+pcjzYCMrVM5wkiemArSFv7WuWrJ+Iz8U
   IfK6XxHbofY13aj3M7VlwN+CcOZcvMg9fQIrRj/w70eAMJenWO2jbubaU
   8+gyjirpDSOiZY+rR4JI/t9vRVCuEJwLo9ULRLvnna0i1j3gkVNzyVtGQ
   IhDiKcQL7T7guZ5xvofZ00BxYDorSH1bxJrOaXR0jAqj5aPrSaQvxZJ8C
   +4AWIwl74eNzbAnx+MHzAdcJMZ8JuP+J1EzWyf/82Nlns0nNNfFCPnUGH
   QJIYTo8u18pdnqS836/HKWeCjl7+OiBXCp9a8TeJBFdQfDoIQewEu3j5h
   A==;
X-CSE-ConnectionGUID: AxIOcH3jToaJ5rFYg9Ll2Q==
X-CSE-MsgGUID: gc1sWbVISeSEVmOFK4kMaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45596900"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="45596900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 00:13:48 -0700
X-CSE-ConnectionGUID: FbcMCzLQTOieVuiZzu4YYA==
X-CSE-MsgGUID: tFI+E7bRS/yXZd7DwO+OlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; 
   d="scan'208";a="77027780"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2024 00:13:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 00:13:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 00:13:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 12 Oct 2024 00:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5m9Lbl5nC1FuuqnmjcGDd4FuK5qn0rAo8WFyK6tE+XaWnUjS159Qepe+eh4KrSKUi25Hu8gRF//U1aiTFgYziGF5qvOEXbLFPvfPtA/lz+9TzepjFuLfWqyTDWmc0alE4zz7orbCa64TRBI4MawcKZwwaEz+/8EpS6cBoao3PKyGc5EHlmtJ8X2liRYVH1htPy1C496zA0BXtZlydrnERPz5CoXZye7t3u+ZSyuCzBR1lr4iJCcblbSdvEDm5xGxYrJAlonn4g9gKNViQzIaJNmUzoxC71IA/Ci0RJx2TqM/fLgPEMNXxOo5Pt8zn2fZhLPLVvCUroqDB5U0qLr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSfipu3t4MDEFMVq6nBpyFUnmjJ+k+u1oVKExbvDKJ8=;
 b=qU4KdQcTdWLDPiB3CNku0d20XQ7cGR7BH8faufWP0bcNw5SWSEE+H9Fau6J/32vyGJlm3/4TGt4wUrjR+pjzGGpacDYXz7y3Xgy8u2cZ0ZPqBTi7rTz6cBhAk6jYE4JnVwlnsyEo7msyGr9qwIdhtIz5+robd1NBnlC+cV8y+hv8lVVifKfqrFE2KN2xe/YWEEMOtmLdau3oKSnllOs5/t3rmwdOwsQvqI7s+fXBF/SDJ7KgCd+hcE1hiwIpLqtiqVvLJpIEXtcjdKjgdt0X1Kwb6+LXf+JdAqgyuq2nZZJlK421UjfQ8dI3FpbG1wpwcwf1/v13IUpG4T7XdAjwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 07:13:36 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 07:13:36 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Topic: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Thread-Index: AQHbDYuXUAG53DdhP0eUk6fLFgfJf7KCy6Mw
Date: Sat, 12 Oct 2024 07:13:36 +0000
Message-ID: <CY8PR11MB7134AA927F62C14DDCA36B1E897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-5-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240923073311.4290-5-TonyWWang-oc@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6895:EE_
x-ms-office365-filtering-correlation-id: 7f0fec93-d61c-489a-e16d-08dcea8d63ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?76DqTSqCawAVMN9lUOcS/+i/ywHPJ5rX9+IJ3kohHqVcxia0xB+YJVA3xyxZ?=
 =?us-ascii?Q?XpUvmE0eWtSKNcpd6nDuvvWm7uGiPOzeVFSEqNtLpNBaFIt4o7Sc2+SkfAjq?=
 =?us-ascii?Q?KB8sDF+rORXL1dga5bpyieMrP8BqX9KjtHWBAQEyrkJCN3e6TG1ZqTcO+QDD?=
 =?us-ascii?Q?K95cbIGCJ8Ad7U+zgV4mTi/Skurv5jZz8hgos9zdHFlZdnUahxCFKpKVRHHQ?=
 =?us-ascii?Q?+j0B93mjy9Fx9RuPgRZUgatyUHD2OlNViX/iHihgn9vBGr0Yr4BobGX2iBdw?=
 =?us-ascii?Q?x4hbLukLIkod3QKx78L/hx7Spa5NMReN3ylD0wJ2GT220t3dYsnYQSAyl5i8?=
 =?us-ascii?Q?Je0xIG4mw/63f5ns+BkcUEjbbw2EefPQjwbqsFsHHto91y8hvpbE3McOWaaM?=
 =?us-ascii?Q?zjpCzmORI16UyHtw7jjvrrPjjLjGeGxZoTi8hAw6s359IbIpS1h0aHCWL6Gm?=
 =?us-ascii?Q?MQkP41cuW8MmId3+lWKkWnjNIEO3IFVgwxC5cehpQ6e+mH9+Ik6jywCC2orz?=
 =?us-ascii?Q?bQrDL0npx/7adJfJrC0S3Y/j/Kgm2FsMXRnq/86qLhRkpsBGx2u01kiV0TQu?=
 =?us-ascii?Q?goF52cMe3Q2BvrSeW2e2ZiYyjLS5QerWs2Htov01H6fR40S19faGd97i5fcW?=
 =?us-ascii?Q?jUYjUVtXImDZcJH2knGAcrpbfPwEPTRhgEuZMpKQ0D8Dd4ddqbu+NChnvqmM?=
 =?us-ascii?Q?zNPdJlcHUtvoQXjYE/nc9OURU10XJypHFD9YrwBvHzqQj0ywdsaiaiJS2gqW?=
 =?us-ascii?Q?/zNdroG2j+tclOJtd+PjElIlebZHu8HuOXab2P8q+T0Y/JJGQVJnWnUvGyz5?=
 =?us-ascii?Q?R2BOr0orSnPNFgvqI06KGXw2QWbmpQwIWE2H0XBJKG3WfKKoVGxtw5Vjobm1?=
 =?us-ascii?Q?tX8VtqK8AOiwrMGxQXy/MeY0gxhkCZIN5ijN7Bw+yoVTn/MmbMAVeSDtxCd9?=
 =?us-ascii?Q?Qz60zPl9D318rmWL6AjYyBaK+pjMfGIeW7UAJUFkbbBPPynK00VnvT/cTTUT?=
 =?us-ascii?Q?dtcfjOrKmmjtQAaKftq9Mqq67okZLjFIO13dCMS6kSvVz2Gu6EFJFVfbuaMw?=
 =?us-ascii?Q?Nn9+qUuJRha6zYobx4Xrjl0J2rlIlneE+oRb5SexyCNslgCjyUxSOPtKHbWk?=
 =?us-ascii?Q?LMyKb0yX1wx54czJUdA7NVjIdlfVkB6POGBH8TtnTITzLF0GOpBImgpKXe4i?=
 =?us-ascii?Q?e4iZMQnOo2oM6fU6q1TfCbiVd96cM/2/561+W+FI7hHYPQGpo/3OtPMxUCpb?=
 =?us-ascii?Q?ZbgIIBEOG8A1jCHJxRVs7brd1i4RMieXR5H/a9ow9UEyArWcKXA6S0scP5on?=
 =?us-ascii?Q?RW2XLv+ls95JH2txUqQ2liXnRmJNbnGjtHSRC+XnansEbUYsPqJXBIhKidqe?=
 =?us-ascii?Q?9YLA52o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lKEaOCrJZPRwkDdcjNTlkglGlGKnfVvFsMujouSFXIVVdZ/AFfqJQEWi8FTd?=
 =?us-ascii?Q?w6qm9nzeL9o52eCmn41HpORUBaN4zhF47vkWXSjfj3G69ZebUZTb3kp+M6i4?=
 =?us-ascii?Q?dITzDnPs/w2OLJc9W/SJ5ysyezmQaJa/H797303gMICYarWz+BYhpyPRSxmS?=
 =?us-ascii?Q?D3iK5mMziwCH4ymweHo+X9SJ6D1G6QEVLC0DYVSvmW1ve2rRxrBRjNmQEvf3?=
 =?us-ascii?Q?5o/EP/b5YPJFS9MA0FRdBBYVsc/hDV13hi/RSeh1BKaC9uU1CcNRgJPQoKsm?=
 =?us-ascii?Q?Ia8Ji7LAKXPrwsd74k/FBzxBAea59O0FdG+Ajyma3zdrURuB/L8Wr9Uc2Q0j?=
 =?us-ascii?Q?++OPfvpyi+veNR5dlHSebDFidsvOe+jRBpztwrwPeQ/y6NK0rIKCrknB0rJ8?=
 =?us-ascii?Q?gwRrBhQS6rv13nGorsBUlRW+R52vq6f2omujBcRLbhEvZvfxkboDrnci4ctm?=
 =?us-ascii?Q?EGo6Z7C+sD9mUmrOY/WBwPEKjaYh3cKTRCcR2/8/MUbpYtDY1DwR/GFEYiGN?=
 =?us-ascii?Q?3h1opLzZN94lK5N1Vl8L5h7BAaQTLdLbsMM2Dzj/VPjPG2KdfPOKsf5SAWvm?=
 =?us-ascii?Q?Wf2abr8wKlgaeb93dWkzRWOwRN9e+H+hONSZTx1YCB8DKwBHCjjGZcX1TO2J?=
 =?us-ascii?Q?9PpkX4DiRu/+E6ek21VT2ACw+Ej9I6gg8ODUKrj/KWm2IOW4wCt9ktZjDIl5?=
 =?us-ascii?Q?hvI/pDpb49f+uNfiAH/hEQn+Tv3p3sPD6ZB/XeOQhDr/of9dOZwazuW3gg4T?=
 =?us-ascii?Q?ElQLcmDVDUQbXqtssAl8DPQnhVuWzx2XggRbKmXFzFlIB7hpcYtU/UF/UEA7?=
 =?us-ascii?Q?ydduQwBCpdoJ50Umz6xMUtZkmEXnibKHTWrw6TVthLr8C3D3hqwyFveObXmA?=
 =?us-ascii?Q?l/Fr/A9geUnPc0oa5N/8/TG/X+TRa1yeTVQWJJUuIgkH5xIkOJdDYE9VQ/Zm?=
 =?us-ascii?Q?kxOa2OC4yk7dEfwArZau2MEjAqaN51gYzvQAOLz/r0pX2LmVm7soNQiuMEpS?=
 =?us-ascii?Q?K8WIUzWq17A27KJzDXNZPjCelQ4hwKuZHn8xoeeXAIMOD0FLtgYpngZOCK4V?=
 =?us-ascii?Q?i/qVxWshOGkITAOTjo1MFQ4WOuuO273S3DFznh3FjRgPMVtXt2znIXWFTDRE?=
 =?us-ascii?Q?MeFwxozZWStbs1H4yUm1d0ugAZ3Xoow8s4Z588Rg+YxDPjdXgHtDmuZW2gvW?=
 =?us-ascii?Q?35gvoQ5AACgdQDKSSh5nOPpeduB6V9hzsS51PGlR8VkNhFEF2akFyrp4YodC?=
 =?us-ascii?Q?eFucLQuWIEd2FVAEFd2JjYZGwSyTk9bhciDBNJeglJJ7r4Gt+NIpfbGCubXG?=
 =?us-ascii?Q?dJpfmmSwQRiq7v9f1xV9mUVrRP6ayGWxWrfFki4MHG6Wd3eNWIvmxbqsFid7?=
 =?us-ascii?Q?pVltxPV4tzf0V5FwW4jKNXyryJg3SGTlHlsEmg82ofeE6nxrzvCJFH/BTbZ9?=
 =?us-ascii?Q?3XTJnEA/pMmx12gvGi2ticVOMS8OZ5r5w62n1TT+oTo+QgnI7xuIImiUG/+d?=
 =?us-ascii?Q?9iebQs9MqSz0N3HphW/ymzMHgwewsnz9q5DQzSky/C+TtnuObYgga6Y3+a+X?=
 =?us-ascii?Q?1jzCOInw5dAw0qV1OROpzq4bmAy74f5AUP90NCi7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0fec93-d61c-489a-e16d-08dcea8d63ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 07:13:36.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yR7S5oRPKsAq2xyGWsO07S8Xs14MBHq2Ug151KX+b+jAcQ22h+7TQ+cciDTyHUoJEG+OozCo0tB8W7N/khcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com

> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> [...]
> Subject: [PATCH v4 4/4] x86/mce: Add CMCI storm switching support for
> Zhaoxin
>=20
> From: Lyle Li <LyleLi@zhaoxin.com>
>=20
> Zhaoxin CPUs support CMCI compatible with Intel, because Zhaoxin's UCR er=
ror
> is not reported through CMCI, and in order to be compatible with intel's =
CMCI
> code, so add Zhaoxin CMCI storm toggle to support the new CMCI storm
> switching in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/interna=
l.h.

Could you tweak and simplify the commit message, like this:

    Zhaoxin CPUs support CMCI which is compatible with Intel, but their UCR=
 errors are
    not reported through CMCI like Intel's. To be compatible with Intel's C=
MCI code,
    add Zhaoxin's specific CMCI storm toggle.

> [...]
> diff --git a/arch/x86/kernel/cpu/mce/internal.h
> b/arch/x86/kernel/cpu/mce/internal.h
> index 836e56027..086b833c5 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -7,7 +7,7 @@
>=20
>  #include <linux/device.h>
>  #include <asm/mce.h>
> -
> +#include <linux/spinlock.h>

Please sort the header files, like this:

    #include <linux/device.h>
    #include <linux/spinlock.h>

    #include <asm/mce.h>

And keep a blank line here as it was.

>  enum severity_level {
>  	MCE_NO_SEVERITY,
>  	MCE_DEFERRED_SEVERITY,
> @@ -334,11 +334,16 @@ static __always_inline u32 mca_msr_reg(int bank,
> enum mca_msr reg)  }
[...]

Other than that:

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

