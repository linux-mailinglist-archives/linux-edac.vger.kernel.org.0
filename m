Return-Path: <linux-edac+bounces-4169-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DCDADEE07
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 15:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38064A0C7B
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E82E9EAA;
	Wed, 18 Jun 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFFc0R/y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFB2165E9;
	Wed, 18 Jun 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253970; cv=fail; b=RHmXn2SZb6OrdFsF9tcoLZQKgJKvaS3ex3mWu39tX8KiVtOFHEtFIgtVrR2+Vyji35sMF5yL0C0Mn6UameePInQD6Gzb10zWau1lj8Tlxuiva0lSgayHvppJ+gd7geym9DU3T88007xjvrOjiVxQRQ195njTSDF+T2dQQuG72ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253970; c=relaxed/simple;
	bh=ShLH3dJ/VUIVjWM1OFvsk1fYebMp3sWmZWb9rJFc1o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rfin5mC5WsfKldQjO6hWcHJam1sOQ7fWUXhFEy9sXR7Ko32Fy2JMvxJyDDq+Tvy7OfXSIOxHaDKcH95e4v/aGVF5aDd2EDPqCVbNyH/s6YanrCjTP2Ce9r1B2HE50K6pTxIVwMXwGvKSLTcXdrUNrS1qmld0D0/qKJuWi9jgV5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFFc0R/y; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750253969; x=1781789969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ShLH3dJ/VUIVjWM1OFvsk1fYebMp3sWmZWb9rJFc1o0=;
  b=hFFc0R/yGYlBPnxy/um58Ha4RC128SUqWJ9SneNjhcfifVZHgrqjK1P4
   FAj8dorEhi8ouWYwYuyk+Er+PBSggvwegFNaqL3+1fbqfszsrQTLX4M6Y
   yvaslJdrczIqfTzRVxqwa6U0ZQfHKu46DLP22jWXyOhKBS9paMYYcdoQP
   Gman0+q2N+LIoin0QvVYeqr//ClkPQwTwMZRPPqx4s4rBfhxAW73mXB4u
   7Lc3xFaXu9XpvyADHyK9L5yJT9LJjSo56AL4HVwRv9VB31eXqXY66p+XL
   VHDRQlUQGzWSlVlq8sL8TyIBox0cvZahba/qWv6dJs37In7g0btnPkHjn
   A==;
X-CSE-ConnectionGUID: zOrlzIF1SYSYgXpqBysUlA==
X-CSE-MsgGUID: dnOhb8bdThiWhsBZHw5Huw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63899557"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63899557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:39:21 -0700
X-CSE-ConnectionGUID: RvaFvk9oTRSvCDMcVrV7UQ==
X-CSE-MsgGUID: IWhHqsfTRbWIe3yWUAx4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149712708"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:39:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:39:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 06:39:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 06:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHRwBmu/Et+NRzgb3E5tpJf20LEjaRI7niKDWTHlS1h/Eh87vJlKkUzhL25H9Akre45hkiPqkhBYb5oqjbS0bn3JU13JkElWt73HZrH5lbFnntgUW7yuM4rni5MvcJxu+ivvHEKXF2n6Z6RYNJej5u4rPp12wx1gOcCPQuvWg/gJmneYXp7/gDb89x328sAL8G4scInG5JQcgpKWFqWWiGld/yEwoTM3FjX7T8aMwlTI6xl8ywiRzXetNZrGn+ZBHKtHeQ/RbqUeQUHWmRMEDq+rd/TJcPAxXeYbVJTr+ylnoYo2THnJ4iuFHODRbN0jJw0QHid8d+SbyCbaCkrm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShLH3dJ/VUIVjWM1OFvsk1fYebMp3sWmZWb9rJFc1o0=;
 b=W/oqGGNdrL/PwJCSsgYpOZiyOM1sUstQOj2mrBf3HfjRafmlDWsonCZoEZljrJiNCkfHfQ+FE8bapAUOqQpsuOAWpmYZd4GospaL4OmGLrs8w6tjUAQiY7co9ebMh1+L0DuJiAsdfduYR9CvAFMUuhE9DmQiq7tL0QUJK7kA+/mVlkqQmiXvgF9qd8H+Q10ZiiHLDoG06s/yO5fYSW1FuS3Qkh5SOyEkCUQ6Kq6Cmbe6qv3wYv/uGWxVtweKDEk/QAPxjQ/NxYn2UXi/BBL1zN0n8WqzJo50nPrpEfS/Du7vEVZBmzp7Z7TJ/sdGCA2uvrrnaqNaXrVCUyMXiXsaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 13:39:18 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Wed, 18 Jun 2025
 13:39:17 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Topic: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Thread-Index: AQHb3//92oSRM+Zs5UagMHP66pMForQIQGXAgACn1gCAAAQO8A==
Date: Wed, 18 Jun 2025 13:39:17 +0000
Message-ID: <CY8PR11MB71341B39F3BF6B1667BF229E8972A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
 <CY8PR11MB7134FA32BC293D5E868016A18972A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <aFK9tnZOPtF2pa80@mail-itl>
In-Reply-To: <aFK9tnZOPtF2pa80@mail-itl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|IA1PR11MB7270:EE_
x-ms-office365-filtering-correlation-id: 7fe274e9-3904-4225-193f-08ddae6d85fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R2g3enA4cytPL2VqRkhIWTYvMTQyeFJaaGlsSFhURDdtRGRNVEExU3UzVXlW?=
 =?utf-8?B?bXVrZ2U0K2p3dC9xZy9vWW5NazFVT1JBU20xVjZ5Z01LRVhqcWxFUmFYM2pU?=
 =?utf-8?B?S2psVmtSZTA3Yi9XNk9vRWpTZ2JXRXVjSkJaUzRWSklvUmdBWGNGZGlqWjlo?=
 =?utf-8?B?NTUzMmRVRWRsNEdSNkVaWFR4NVVuNG1CNVUrTFpxVlFFOVVZZVN6M0tweGdq?=
 =?utf-8?B?V2RFMDE1c2g4TGdVU0hqWStmUzI4V0ZkY0huZDJNUFltNzFYVHcvQVBJdkJZ?=
 =?utf-8?B?Y0VGTUVVRlNLc255YTBLM0hRRjUydUsyZWFwSUhCdi9RYjF3Mk52N1lvc3pE?=
 =?utf-8?B?aTdtcnd0WWwwNFovazlic0VwM0VkcG1HL0t4VkVqYXNCcGNFK0k2Mk5DWE0w?=
 =?utf-8?B?UjQyTEZjZmw3VTJGSmVNZG9vTFlidk54bXpCOE5ST3hHdUxEeTNoTmdoaFBj?=
 =?utf-8?B?YW83U0d2emlFdmtXVXdzV3FJSUN6UEdIT0tMNklyU3pNemVXVGdEd1dudGN2?=
 =?utf-8?B?WStseFhJVjNtdzBycll5UFBmemM3ZHpEQTBHK1dJZUlxRk9nT1dxWXBLb2Vr?=
 =?utf-8?B?dzdQR1FFWGVyTStPV3htRzNRWXdUSTV4cnJJbHkwcmR2Z2lKTjMvbU5xVzBl?=
 =?utf-8?B?T0JEQllHRXNnLzZuTVhzL1ZQQlFudWNXc1Q4QTlOeUNYVVN1Rm93dy9jaHR2?=
 =?utf-8?B?MHZPU3VCbk15aGFLdW5DaWlXNC9NVWIxUEEvdzJJSjFzV3VPSTQ3dkxpYm44?=
 =?utf-8?B?cVRTanFQVUl6UG5idUQxalE4Qkw3enNsT0xaVTczazBmbVAyQ2Nxdm1teWtP?=
 =?utf-8?B?RkhIOXp6ekNpUkFTR2NidUpKN1Q3SnBjRnROditpTzV1WFVSYUxCV0lNN2Ev?=
 =?utf-8?B?ZHhjaEZBckR4RnpjNjJjL09hMkxRK1hvTXI5RnNHRlN3MUdhRVB2VUxvWWxr?=
 =?utf-8?B?UXg0TFE4ZE4wY0tXK1ZrQ2JLV09aeGdZejU4WU8vVzdQbEZIT0p4L1Mxb0cz?=
 =?utf-8?B?RXFiQnNBZVYrc2MwbFFaUnMzMEJzRE5pY2tlRVVQZmFxR1NKa0ozNDczV1o5?=
 =?utf-8?B?ZEo1Q1ZqSVl1NUJqS3duS01vOWpTZjJkdlhSRTdQQ1pOelJneXptSXVNQk9n?=
 =?utf-8?B?R3huOHBXNUFhN1FGcjlRUTBrZld6NjFWMUU4YjBzODRBbHIydERiZk5HUGZD?=
 =?utf-8?B?dHdaZFdLeTdlN0pxYk1XNTV5dVc3YTNEWkJiRUV5OU9VS2RyM1dnN1hpb20w?=
 =?utf-8?B?SWlLN2NVVDdNekxsYmhVZUpDVG1yTjFSdDBheHl6MFV5cHl3UmpPVTR4ZWhj?=
 =?utf-8?B?NnJpdVRmRGlXc050Y3RtUlo2V3p0YTdmTmo3NXltTmphdXBaOGt0ZVNYQndC?=
 =?utf-8?B?YkwrM3Z6OStxUTNGbnU2bHVJcXQ4VXcrWWR1NXBoYUZBN1U5c2tMWmw0YXZG?=
 =?utf-8?B?YmdYMXFZKzl1anR3UmJVTDlLUzZraWppaFBGeXREbE52aUw0Q3BXMGlIVytR?=
 =?utf-8?B?ZWw1Qm1ESDBQUDBHbW05Q3VpczhHelRTRG41YkYwOEZRTjJLNndXLzBIeVdm?=
 =?utf-8?B?RFN4azlXSDVHVlZqYS90Ni82L3RaSUEzSVJZMTBKZU5RUnNqWk9jUCsySVNZ?=
 =?utf-8?B?RklheFUvYjRyYWNDUnlPcDBWZGppeWFZWGdpQms1b3lOYXBaajc4QzcwcjJK?=
 =?utf-8?B?WkpXYmIxd2FsWllEMVkzRWJDdHNHMGNtRjZxb0I2TTZNa0JjdGs3eU1tRGdv?=
 =?utf-8?B?QmVldlhHbnN5clFCZHlrQXlhbnd1T0pZdlo5dlhsa2Q5OVZGcCtYTjltM3Ft?=
 =?utf-8?B?SVNZQytaNmQxTjBMQWxzU1ozRnBScUcxRWhBR29JSDI4YVljOGw2b1BReHA1?=
 =?utf-8?B?MjNMdEpQUmtWSkI5Nm93a1RoTkhFbTlQRUp4eW9XVi9pc0lURFJYYVNqa1Yx?=
 =?utf-8?B?Uy9xdjFkeDNTZDRmRGx1RlRQQkt4V2NCb09sS2VlRFRSWGpuWlpwLzhQTTlE?=
 =?utf-8?Q?lcUGtbxvMe59yTCymHBkTZm07V8l/Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmtMVGVyUlA3WTU5cGNLdjIvZWJBUk8yWWtRSlZzQWl0dkpPZXQxVS9Ma1Vn?=
 =?utf-8?B?b2l1Q2dLaU5aczBZOVpQOFlyUDRUb1pnb0NvY21hdG92MUVWM1ViTCtoZzZy?=
 =?utf-8?B?VmdKMTMvU2FkZkhBZEU5VEl0UklFNmM5T2FWZFJkY2hlMjlROHFlcUVuMmFR?=
 =?utf-8?B?Vml3MFZnMkl3VFJjS2QyOForcmpmbk9jVWlhUFkrbDBsVldjQ2g3ZnZGQXQr?=
 =?utf-8?B?TDBqbnRiV1BXTXUvUVJoY1B3Z2hhK2JNMXo5UXg4aDhtMVdMaEtUT01ET2pZ?=
 =?utf-8?B?bFlpYW9rOUJvQ2RyL2dlaERJSDh0RDRrdVlBblk2V0VlaTNlZUlVTURPWGQ2?=
 =?utf-8?B?Zldwa084ZlVNTktpR1BmclFPOERybG9qZGJmRytiZTB2WHh1dENyV0FIM3Ju?=
 =?utf-8?B?bUVuNHBsUWYwWEZKdnhJRWFJUFpoZmxSSkNzMzZpMUF0RmREaXloRlhOdDRn?=
 =?utf-8?B?MVBJN3VzR3NIUzdhKzdxcTVNbFVZNnZCYkdpZm43azhmODRlcFlMc25mOHZQ?=
 =?utf-8?B?dmRwUzRUTHB3Zjdtd0NUdWdubEtvTnNNQzB1aVN2VFBrcEg4QlRWVHJVakU1?=
 =?utf-8?B?UFFvVkxNejh3WlVubjNRcXBaZEdkdDhsVXV3bHNBVmJTcXJkMjVIZmRrOUZZ?=
 =?utf-8?B?dldaU3YxYkpsZ2lCMitjdllQNWFqUFhDYVA0ekNINDRUWXJJdEJ1VXFJVStJ?=
 =?utf-8?B?U0x0c0IyVUJTSDczL0MvdW1KUk5ya2owRFNOMUhnMXAySzVzNk12OVBnQVJo?=
 =?utf-8?B?N3B5Uk1RSm8zSldvYXk4cjd5ZlU2Tmp1YmZtcU9pS3pjMllyS0QwZGpDWE0z?=
 =?utf-8?B?c1RqQmRUSThHbzFrbks2dGVMQWpjTUpnSmRNTnhiU25MRFFzMGcvalFjSWcv?=
 =?utf-8?B?YjZiWHZQT01LREF2UHRoVzUxWEJhK3JMYzJ6ZnJHQ2lWU2E0QU10Q1YyZDhL?=
 =?utf-8?B?a1RWNEpiUCs2OUxaL1Q4aEZ0VUZycUw2WnpPUXBFSHJnemZ6MHlZRVFIZWk1?=
 =?utf-8?B?R0JsZmlXQkF2TFFPMXlpSG9zZ0tGK0w4M1dTbUFidDFoVnNDb0Z6VXUxbWN0?=
 =?utf-8?B?ZUo5K1FBZXVEMU1FZW1mckJ3ZHUrMS9VVTk0V2lpSW44QUNkMk8ySFl4MFZP?=
 =?utf-8?B?MmYxRUlvQUdDMHdQWmFxb21XUXJrYjhTaEQzWDRoNkVKeVV0RThNTVNpUU9C?=
 =?utf-8?B?MUZLVmlDYmdDd1FlcDdKcVRJYjNRYnBZOFlFTDg2SFVPU1djdGxDSFE0VHhH?=
 =?utf-8?B?OXlIY1BWanNrNU4vWlQ4d2liVUNTRXdieEdUcVJxNXhiMnp1a2JIcGhLemE0?=
 =?utf-8?B?eVFtRk9laWN4eDg4bENJK21Cd01sU0h2MTZENWZuRTRjTnE4VXpweGtaMWRr?=
 =?utf-8?B?S3l2Zy9hNjZxekpYS0JYUUppUGI1dE5YMWFWbG94Nm5rclhKMkpwd25ldHM0?=
 =?utf-8?B?V0pBNEVpSUFYa21UOGVrYnpVN0JHSXJyU1FDbS9xMzZWNkFrcmppeDl4bDh5?=
 =?utf-8?B?S0NwWWkyUWpzazYvN2IrS1JpWkt2dTZpKzF1eG1NQmw2T1BmSXFRSnZrbm9Q?=
 =?utf-8?B?WUg3dWFWZFYwOWpBbERCVFByNG9Tc0xOV2ROMGJCSUU3VHZtQis0TUM5dVp2?=
 =?utf-8?B?QTBHN1lRbkt6TWlMTEp4RlVESlhUYXhVUUQ1a1VxWW1TSGRMTmFwcis1S3Rw?=
 =?utf-8?B?UzFVeXNvbFJMdmM2UllwL2hCeTg1NW81ZFlXOEg5R3RCZGFwWC9aM3ZxQzhv?=
 =?utf-8?B?M2Vnd0VCN2E2WUt1T3RaMzdDVFpwSnQ5aDl1MTJQb2x1TUNQbEUrUStKOVF1?=
 =?utf-8?B?ZUhqTmZYRVVoZmxhY3ROQkhFMFFoRVE1YnEvREcrbTc0RlJBRDB1ZVIxS01x?=
 =?utf-8?B?VVlqUk5SZWE0cGJUL3UrSS9OWFIvWU1jd284MkNjMVJ6UENTMEkzRUEybGxn?=
 =?utf-8?B?WFRLcnA0R0pGTHRSRXY1N01iZ3pRMXhBdllTUjkzaDZhT0dNTEpPZ25zd3NQ?=
 =?utf-8?B?bVlhc284dnRGYXZrUGp3UlAxb2cxRVprZzFFdEhoZ3VlSHZZV3hsR1pLdmt3?=
 =?utf-8?B?NmdHVUU5dWduTFRxUHRRbmZFSk15NnFTUVdtUnpsektZUVNtRkVzUlRGYnNa?=
 =?utf-8?Q?rzKTABVOKzDbYUL4NMMXsBsAZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe274e9-3904-4225-193f-08ddae6d85fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 13:39:17.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wz6oltnNammdCdVhG1HEL1LFEbnpIBUF8ElwEyDKRfwivqgaZgLsE2vaO7acd1dSgGzrUfgeTLBtPDG+BM2tRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com

PiBGcm9tOiBtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIuY29tDQo+IFsuLi5dDQo+ID4gQ291
bGQgeW91IHBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24geW91ciBtYWNoaW5lIHRvIHZlcmlmeSBp
ZiBpdCBmaXhlcyB0aGUNCj4gaXNzdWU/DQo+IA0KPiBJIGNhbiBjb25maXJtIGl0IHdvcmtzIG5v
dywgSSBoYXZlIHRoZSAiRURBQyBpZ2VuNjogRXhwZWN0ZWQgMiBtY3MsIGJ1dCBvbmx5DQo+IDEg
ZGV0ZWN0ZWQiIG1lc3NhZ2UgYW5kIGl0IGRvZXNuJ3QgY3Jhc2ggYW55bW9yZS4gVGhhbmtzIQ0K
PiANCj4gVGVzdGVkLWJ5OiBNYXJlayBNYXJjenlrb3dza2ktR8OzcmVja2kgPG1hcm1hcmVrQGlu
dmlzaWJsZXRoaW5nc2xhYi5jb20+DQoNClRoYW5rIHlvdSENCg0KLVFpdXh1DQo=

