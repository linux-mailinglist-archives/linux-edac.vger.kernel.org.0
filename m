Return-Path: <linux-edac+bounces-5701-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHXvJG4cimmtHAAAu9opvQ
	(envelope-from <linux-edac+bounces-5701-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:42:06 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C46113246
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4582530036C3
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131837FF49;
	Mon,  9 Feb 2026 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4m1VQ9a"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08522D94B5;
	Mon,  9 Feb 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658747; cv=fail; b=VmjxDaJVfZTKSVj5w3Iu1u1xMNscIoDEWS1wRFIiSsebrpewcxZxExMJ+2mnenEQ34NQnpI14SMFmhYp8Zaxf4C/OueQGjh7gGq5qdlLdv0VYXyy3W6X0x7UV4wuFI+gWrtQW6SLK5F/Rn/uOR6KP5DDsW0gnzji7Lycjl+Bbvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658747; c=relaxed/simple;
	bh=85l/BwpNcoyLudkVPItGZm0WsJZn+fRJdKN78rtWrRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mwUVqNFj2LNq135Xgw63SwQWzxHTwuJs9ylbJr7030SiSnQVOIu7lcI3cQv9rVSINc/6Ns+/AAniJsqhsULULkOEA2KAErRQyAEMrfm4oqV3bEqXvYYXabQp+aVf5rRppEh63rZwJFwxJK2RuYj5QeV+CHscFh6j0BlV5fH3oos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4m1VQ9a; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770658747; x=1802194747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85l/BwpNcoyLudkVPItGZm0WsJZn+fRJdKN78rtWrRU=;
  b=C4m1VQ9aqg1aL7v4DcQ5t5quARAVJg+q4Ec3OnZiIjITSlamJ4jgmaMM
   elASg2qF52fUI5QyxZloPbVQMNOWDm7GIGax0NL/PD8pzh1aXCjD4rxj4
   IhQzqqF6CJWvHcXoPJgx1rRTtxAzcbPtqjScHWEOZHAL6Ek9xU6F/RwmS
   iQWVnuCD+zXnUtF+Jpm3Mg07CotWFrTjJS6H+D0LvTIFtICNNDedq3zRv
   NygNLGdkKYD6YQJrUBxPxbuaXejZhNEcVraXto6Z0Y1SR6S7+DsnrYmqJ
   YV8UIEJlIAsxis8pJQJEv6iXsl+O8ANueB3a1s9xaASy/4us+VAWCRPDN
   Q==;
X-CSE-ConnectionGUID: us2MOv4RSbSr/nUJkIxw4A==
X-CSE-MsgGUID: 8iNZRitVQAu7nxwtmuTsuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71960718"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71960718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 09:39:07 -0800
X-CSE-ConnectionGUID: fTC1G1N5ReSApu1AjCPtBQ==
X-CSE-MsgGUID: XI2sIA/oQ3arsRQAAeMPZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="216174713"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 09:39:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 09:39:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 09:39:01 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 09:39:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZJts5fdNqJMKgxTn6MIUG3X+rpQ+vgj1DpZt4oHlNoxd1W4HU5XNhPiwHxb7O/ikzRrvDkunHizywjTBWC4rhkHIhJRs3YoBlr8PkQ46phK8fbC43sIN+AOJPWiT79au/TItmdGLnH+6F9Oe+WqIHA5L/AI2GbsYcwCziGiQo22+dl70yexME2l3rY4EUmP7R6cfWbtJ/1oHVFGNG2obSifgWue02ewPa/rjR7PPJfZDbWV3b2y/uHb319J1CtqrCdzLLtwmgQVIDSaEf6NVIRp1Q54A0vyvcGKVKabCrxqfQvJSdSNyEWwduTq8zhJ2GSdC1UFStnkN0KZ+b5wjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85l/BwpNcoyLudkVPItGZm0WsJZn+fRJdKN78rtWrRU=;
 b=zFmd8CIERBMDbJSwhKQp31y4vviRwbzBbaPsySQrqaeIqg4bQFZOabbVnt7/FF5fL3k1FqhddUTkTovyvOygH2tDkQLLL+GodBupeMsfI1eGf3uZhmrbqM4k2nJl55dzVdMCQH1FYuF+3GOqVq6bCk7StADHnqMKWq8yhE0bXTaHz3LDU+xCqBStwX/J6tb+zbFYnGtK7C+3x7AGUJRJUqk1dStbT/OTYiD/tW1Kw1Tiipke81Q/bU0/Jq4+HPq29lntVLAZF77QtLU7u53ItjviUaPxZ3ZH5ueBupeY23oiF1cNXLFfqBLaaaQLFeT4UItvBjIUd2OwTsKFh2PFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 9 Feb
 2026 17:38:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:38:58 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, William Roche <william.roche@oracle.com>
CC: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, Thomas Gleixner
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Allen, John"
	<John.Allen@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jane Chu <jane.chu@oracle.com>
Subject: RE: [RFC] AMD VM crashing on deferred memory error injection
Thread-Topic: [RFC] AMD VM crashing on deferred memory error injection
Thread-Index: AQHcmeJd3JzNKlpld0GJhDXRmMUdZrV6oW6AgAAAgyA=
Date: Mon, 9 Feb 2026 17:38:58 +0000
Message-ID: <SJ1PR11MB6083618404B9418F0BDB6AB6FC65A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209173619.GCaYobE1nME_z-1z2U@fat_crate.local>
In-Reply-To: <20260209173619.GCaYobE1nME_z-1z2U@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: 49fc574d-aa19-4fa5-cbb4-08de68021b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eE9Qc0hmeExXdFo2bVdzb1lsRThIbDhWUERkR1JscWltQk9rYlp5UlYwa3pW?=
 =?utf-8?B?S0xqUVZsc1B5SmVVQmlUTFNOVlRXSXdYcUdBWXd0RGw0eXdEL2pzUVVpS2ln?=
 =?utf-8?B?RVBmY0xHTkxNakVPa2RmYnJQeG9JVWs2OW5UUnJueUpydUtsNmhTaW5OV1VS?=
 =?utf-8?B?Z1lqVmlrNHFYdnpyZ0UrV05RN0M4WHVxQ3V5dm0wbG03eURQVkZCN1pSdTlv?=
 =?utf-8?B?Q1hTcm5Bd2xPREtaMkRudzNsQWU2U0M4Y1Nra0lVUzFqZ0p2SjVXT2FNUG1s?=
 =?utf-8?B?azZKV2RQNWVyKy8rVGFpVFFHR2I1MUQ0K3VEcGdwTkRFZzNOQlNPZncwZHp6?=
 =?utf-8?B?VDB2VVQ4b1g4SmRYcG1sZ2RTUjFCMWNja09zeXFmSVVQcEY0VjFXNWdpbHlZ?=
 =?utf-8?B?a1JTQ3ZWOUdIdk5YYVQ3YzQ1ODJuUWFEaXdTamF0MjJ5VTB6cTJ2dUp0NGFy?=
 =?utf-8?B?ZHArbWZuTjY1RzcwSmtkaWwvNGt0ZFdZaFlWSW1xWFVXbEwyaU82ZzdUL1R4?=
 =?utf-8?B?SVRNajB2SW1IdHZGNlpYZ2hCUWdGcjQyQnlpbzJuOVI0NUkvS001UURPS01R?=
 =?utf-8?B?Tm82MWJFZWt3WU5ydFdLTnBJTDg3c1hWTGFrYlFrMC9HQTIxc2taMlJzVXZE?=
 =?utf-8?B?UGptcERMMDJzYVEycTdNR2NEUnRpK3psRFZHdWpZYXJ2WDN5R2Uya0tlMTJk?=
 =?utf-8?B?UE04VjlVQjFGUXRCZ2hTTFp4c2xuS2FteXpZejlEUWFUMTZKU3dvSEcrTS9j?=
 =?utf-8?B?Y21XLy9DeFlrNnArWUdzRUdWYjFKMWZ5Uks5UGhNaFp2ZXg3c1dndjMxUVRS?=
 =?utf-8?B?QU1lZTJmM29iTXdjUS9BV2ZIV1NrUTM5OGhMbHY0clkvaG1YUG9oeFdUQTRs?=
 =?utf-8?B?MzMraFp2eTBxcWk4bDhMKy9UZmdoNEg0UVdJUFpOMm90eGFkdGNMdmpmRFRP?=
 =?utf-8?B?SGc5b3Y5V2hCYlZYaVhRU0pzL2VqL3FDS3hPNjQ0aWFJOStqaUo0ZW4vNjhX?=
 =?utf-8?B?aDB6V0wrMFhjWkRHcFA0aTg4YVJjTVJZOVdBSldYWm9DZDVFNkgydEh2VHFO?=
 =?utf-8?B?V3lOKzJSNDFhbllWbjBLcTJsd3dqeHZqWU0vdDF6eTljc1g2NVpma0JtQUw1?=
 =?utf-8?B?cThDOGxjVUx3ME1lWk0zTmdVSjJzdjdabGJybEE3eTJZUCs2TWQzQ0dkUm9H?=
 =?utf-8?B?R25GMWtNK3p5NmlldFhlT2J5SS85dkMzRWNWUUtzd3dYTkM3QmVWZ3lsYnFN?=
 =?utf-8?B?b1NORitSRXlzaXU1WnVjN21TVytVWWtRdVFlMVQvL1BPZi9HTnN6SEY1QUNo?=
 =?utf-8?B?Ujl2RnF4TjhFWURBbE9UbkdhVnNucytjejEra29MR0hBNnhVUHR4YXdVZXdL?=
 =?utf-8?B?TVk5RWt0MXJVUk9NQTdNd281Qml4VUlRcVQ2UWIxYVozQjVoYklOVXVZT1Nt?=
 =?utf-8?B?ZHJudWVLQUk1bXRSRUYwbVhWMG5OeEtLQXNoTVlINUpnMitudFNRK3JMQUZY?=
 =?utf-8?B?bmphMy9NRnI4R0MzTnFsRWg2NTltRnBrTWhLUVVpMFdUbGE2aGlJZ2dadWRx?=
 =?utf-8?B?QVhESXY4ZG9ZU2J6M1dKdWFnOFVtSFM5Rkw2aElqQ3VtRTRQaVF4U3F4d0E2?=
 =?utf-8?B?WkZKak9rTWRVdjFpL2R5L21UazQvNWhwWHR1aXpPcmFnUmI2RjFnc3R4ZUdi?=
 =?utf-8?B?Q0NiSHl1S0xSN2R3UytvSzU4OHBlRURTVXZPbU5uTjA5WForY3RXRWhYbm5T?=
 =?utf-8?B?SGlFOGxXN09Gd29tb1U1ZHBsZWlxWEFnamRuQXhpMFBuWWliOGt6TERaSGdv?=
 =?utf-8?B?dlZTY0ttWFRvOVNuczhLMmwyVkZjZ1RORmNBZ1huakxkZE9JWFZtb2NMTGtu?=
 =?utf-8?B?dFhjT1VRbkhJN1Eyd3UvckJkeldWclFGVGRPNmZLeGdtck52U2pxa0FVQW1V?=
 =?utf-8?B?NWVva29ZeWxCS2M1cUlKc0wxMU5PaHZVMkN3MXRpY0JsWFI3OGNpWlZaUDZL?=
 =?utf-8?B?MC84WnNoZThaQjJRUDFsaWJzSDRDcGQyQU5QcHYvZ2FkSmZocVJ5MUNkTVQ2?=
 =?utf-8?B?eWpHbVB2VlVlSWhxTDdudWJRUTdKUlIySFZ0Q2FmTlNzZ2JscFFCV1hpclpF?=
 =?utf-8?B?cmUrUWlzK3BVdXZBd3IvYnY4RWRuR3ExOU5BbzBmcWZ3bThrN2FBdXNHTDZG?=
 =?utf-8?Q?QvgKjR0P+/uMzON1hdhwk34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEpLcVppRzlSVU13c1VFQXBDSVlYMDZlR2RYWm5RRldiOFErOGs3amp1bmZp?=
 =?utf-8?B?VmU3WDMydVVBUUpZQWExT3RPeE5oVHBwSTF4STFtK1hBdklMTmUvTk5ZWGhm?=
 =?utf-8?B?RlZueW9BTDllLzR5WEt1T0E3MVFKSU1yOGtjQm40VGZZUThicE16U2haeW5Q?=
 =?utf-8?B?U3hmdWZ6VFlscnNHU0xwYlNxeEYrK0ZLblE0ZmlxWkhra0oxcFBsNnlNTmZl?=
 =?utf-8?B?dVVWWVRJbzhqMC81N2xLNEY5YTB5Vy8wcFNIM2J2SEpwMUYyY3k2WVRXaHB4?=
 =?utf-8?B?K2czUXhqdmYzS04vcVRqYWlNbCtpWmVOZ2tuQlZMc055S0VPYUxyVUpmb0I4?=
 =?utf-8?B?U3U0c05weEw5cnNheWVCRkdRZVFVRjFNY25LVW91eHVQTzQ4UmpHVUs2NGxO?=
 =?utf-8?B?T1UzMWZiVnQzdDFnNHhSelI5NkVRTUd2SGdySTgyRk5qaTlla0hUN0xHUUt6?=
 =?utf-8?B?OFdkNWVwNTlsSkkvakNMdVBxMVZ4NEpOeGNZaFNiMG1YQWNqUHpEcnZoSGh6?=
 =?utf-8?B?L0N5Qm9OVVgrTFBiTlBhQmkrdmZJRmZ5VWl4YnBkVldSRFZ4cVlvZ1o5UUZV?=
 =?utf-8?B?YTdoYTZjVWxWVFZvdC9MU01TbkFPMDU2cDdKb3JxWjJleE1GSmhLK0dJSXly?=
 =?utf-8?B?YmJpR2ZUU0VlOXFYdGh1aldtT0ZoNktsNXd5MG4xVzJIakd1WTZqSW4vZ2N4?=
 =?utf-8?B?d1JXanlheUJMY3NUalBpc0xhMlY0V3Y2SVFtUm9vWndkRGFJcmtRVlNnK1hl?=
 =?utf-8?B?OWNxYWI3TU9JbUFwZUNBS2tGWDdhTU9ucjNzUnhHL1duMXczQTl2RnAxcHM0?=
 =?utf-8?B?N0d2c05BMmdrVGFLVEg3YThCVTVDVHRPd2JvTDdSQ0Z1c0V3b0JmbmxTQTFX?=
 =?utf-8?B?L3cwU3cySmN3YmsyWWRwWU82ZWszcmkrOUpnZnNTL2RiWE5wbzFhZ01Ud2t4?=
 =?utf-8?B?cFRNYmJYQStFN29QTktsT3hUbXVEQzNlMDdFdnUwZ2VIc0U0bS9GblBvT3hP?=
 =?utf-8?B?OHpTMzFQZVdTVTlUdEtJbEZiK21NSzJ2Nk5JRkZlRkdOZkVkVGFRUkR1alhB?=
 =?utf-8?B?ZW95NWtTZHNkV1dlNkVmTlZIdHBGK3lmSU0zRDFKa3YzWk41dU9naTBZdDNX?=
 =?utf-8?B?RnhEL2JGR0hXeUJQRTlIcGZYV0dPb2s0a05PYjlrdVB6TGRZM21wUkNUQkFM?=
 =?utf-8?B?WXV1dHAreVZtdHMwdWpRTkR5OG1RWWJIQ0s1QlUxRkNObEk1aWVFeEwwUXNx?=
 =?utf-8?B?NnBmY055YzJ4YXEvQ0pXVjU0aU9BWWRWU2pjTllkN0NxYjFmNnFEekUycGts?=
 =?utf-8?B?Y1ZucklaZ3lnWlE3d2hHUGJCa0xkRmV3Q2VSbEoxUC9CU0diWHdyN2dNNjJ3?=
 =?utf-8?B?V1A4T280OGF6RUFQb29LQ0VZZ1ZGZHpQaVE3anpMV2xKUytwQmNzTHF0SUV3?=
 =?utf-8?B?cTJMN1FCRi9YR3YzM2lzSlF2Z3k3V3dKODdQQzdzYUNtN0l4b29IUXJHV0ZI?=
 =?utf-8?B?WHdMR2JWVVdidXpHK3dJY29Eb0RYYi9pa2NpL2RyQzFETnJ3cndmUGdJQ2JL?=
 =?utf-8?B?TzRkNTNodEt1U1YwWDdSdmU4OUN0U2NEejZ4NHFVbERnMzdtYUtyTHRjZnE1?=
 =?utf-8?B?S0hmeFVFMmliR0g5ek5PbE54ZGpTTVAxa1V3SmhQbDZqTnRkTmMyWEM4S0pG?=
 =?utf-8?B?NmZXdWFuS0h4SFlWeWg3WjZ0aHZQbm54T3piandzMmpvWHB4WTROS2RjTlVN?=
 =?utf-8?B?QVRiMmxmT2tOZ2FZeXBQemNFS2ZnQnFpMitOLzFmcU01Z2xzeXpzSWVoZzZF?=
 =?utf-8?B?VkpwS25EdXJVT1BNQ1VSV2QzUGhnYXZOWWhqRmhCWjd1QUtQL2xiWXByRUZp?=
 =?utf-8?B?K2htT1ZOVkJHYnlrMk91cWZtSitVWkhzbVM1MkUrdXgvTTRUdktDcTRpRkY2?=
 =?utf-8?B?aUFqeWIvQm1PSzFSazNPSndpeHNjL3o5R040MlRrWG9tZFovUGJBd3d3b252?=
 =?utf-8?B?dEdBbVoxMmU3cmJQb1YwbHN6enFqV1pZSmVMcEh2Z1htMjB2SXVMSlBPWGRs?=
 =?utf-8?B?VTRnYUY1Ykl4T1Z6aFJYL09GSDJPZnBWZDJkY21rNzhyVjIwRi8rWEhUS0VL?=
 =?utf-8?B?UndzcVNUelFtMHIwWndXc0tHRnVKNHlac2RNWnREcTEvaTAzRnhBV0N2aTBx?=
 =?utf-8?B?WmF0SGt6M056OWl0aWV3L1Y4UFVwQWtwWEJnS2cyYU44QXRKN0piTUNzRHVR?=
 =?utf-8?B?QW0ycFpxZk5RdnlqODV5OXFnMzMvVzF0czc3aStVeFlWUG42dDRJc004TDVS?=
 =?utf-8?Q?ms0cljkFx9YSAbUJ61?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fc574d-aa19-4fa5-cbb4-08de68021b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 17:38:58.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dRF478xC9VbQK1qsZzUcoJvV90wUcQTICB3hA8jJI1ImlEhJAg0iUMn4W3sCAokpGTGiwJHayh0ANmAQYT3nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5701-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony.luck@intel.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E1C46113246
X-Rspamd-Action: no action

PiBUaGlzIGVuYWJsZW1lbnQgaXMgbm90IG1lYW50IGZvciBWTSB1c2UuIFdoeSBkbyB3ZSBjYXJl
IGFib3V0IGluamVjdGluZyBodw0KPiBlcnJvcnMgaW4gYSBndWVzdD8NCg0KVGhlIGd1ZXN0IG1h
eSBiZSBhYmxlIHRvIGp1c3Qga2lsbCBhIHByb2Nlc3MgYW5kIGtlZXAgcnVubmluZy4NCg0KLVRv
bnkNCg==

