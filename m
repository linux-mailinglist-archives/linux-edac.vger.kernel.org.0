Return-Path: <linux-edac+bounces-5686-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGPIJ8KRe2nOGAIAu9opvQ
	(envelope-from <linux-edac+bounces-5686-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 17:58:42 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B415AB28C6
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 17:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF52C301F982
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40633ADAF;
	Thu, 29 Jan 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMy/hqQN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA919E97B
	for <linux-edac@vger.kernel.org>; Thu, 29 Jan 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705668; cv=fail; b=ZMiQw5q+vJNTjCX77xXvZSClyTm3PslMVjF32CAW80URZkCSqHxLfzuScn3gVW72QS67fYVOD3STMDA51XkbubOa8FX+Iv5/9WA9L7MDvn9K7ZTJp0f1MpL64GyDXgfipj34w0iQvio3S54KD5ozejM3c/NrUd7M+5hoCz5P0SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705668; c=relaxed/simple;
	bh=IabI7X6AjubirakfxB9bKVSchal5pOCR1t76k3TYWvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OSA51xbetulzkaRoSE2rp9Ngh1hpeLJ5ngY5pZFJlxkUU8VLG0kvBdsm5QVmqkmK2UqSrNzWwq0untzFhn6Pe43u0fw1RfHoTw1O2ETVJbj16WVKz5L0x/yJwjLDvOpKs9qRJgI/CaRAC9lWg++1c8/fwIW36pBObr6eicDndUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMy/hqQN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769705666; x=1801241666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IabI7X6AjubirakfxB9bKVSchal5pOCR1t76k3TYWvc=;
  b=GMy/hqQNZ2u3PoRkngDMye7zRExnX+7iXPGgEYL0H7AHw/DweQrExeK0
   iW+wT70ZTufhVSqh5CaAhkHeoAyio8HTMLJ3/tRmsKDEHWFG6+tbZ2CAB
   Q7xl4uZtbUiwmCTGS7hfFfTTrU/QIWjLVdzAR4JGDETmtsoKlzL/6e0NS
   6WZE0g9ospJzgeys1TuMjze2F7ojySbTuVrnuF2CcQsBcx0UgW3xpEQmF
   yi8pCobwEEmHN1k7mQ6RFH6JfmLdXGI+z8Qe58kv5qt1PHfWfQkkyEoiN
   triD923JkPq1fAbwPWj1WXM+1zmRICTIiBfgDFAFoGYwXqUJftnk/FKWE
   Q==;
X-CSE-ConnectionGUID: arjQLefaRPiPikMVG740Wg==
X-CSE-MsgGUID: ucmSmJ+DQKynUbqAeZRg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="73545622"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="73545622"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 08:54:25 -0800
X-CSE-ConnectionGUID: xxzGDHGJQFGzFg0xgBbEXw==
X-CSE-MsgGUID: vTc7xtEjQUSmJCkatt2rDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208408728"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 08:54:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 08:54:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 08:54:25 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 08:54:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqhkPmbqagbwMVpcuR/w0KG+FVuqYSOQA2va1sSpa0TYqv2Xv7w3bLJX+nlePk82GfYRj+cSm0hAFea3mSZvCJdK+gkuxyzG2XQGC6Zwy57v0YzhDtRXwoZ8SC6N2FmFNNw0XS/N+jw3ArRO8OQpU9ljlliNdzTx8Ap1JqZA1f48AhwDbvrVmAN6PV3Cyd6w6BkckeBtUpnV84Hd4z0L0MrrUACaikNtdX2Ihct1HNabRPzDJ9lT0nmryVpL6weRgQ3Wb4aGbdf5BQngxWATTahG4R3DPPAzVwxSzN0joFpK0jpNo60LSnn5O6KgdBM1qnX0lNUuFSgA9nX0RE3LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IabI7X6AjubirakfxB9bKVSchal5pOCR1t76k3TYWvc=;
 b=C7VMlW/LyfizCg1u4BgVzrmykKLgz3KSNJk390EuFAPyE0U/uXWUEnDwzviK+5ArHAPHVh55lQEBJ1eC4JewqOuVRSMbZpmM2q9WhsF4ypkycEdxu9BljO/yWElXyUPGcHgmHPYfY7gIxEzWla9Oir73k4//LFE38vJzSJQuu6TOVcJGiicnU5x0UiZbw1r9xFQYqvVbHZ8P6I8UoPYPOHVJ80pEVdbZsLvVlE6HRxNiTLxItYRT9xute7es62ckDEDN2wiNmR3JFuPoxHNwkVT9F10TKSZECdUOvPS55/n5GmzJpJJRkWQv7gdki2hiO4UqnNAlRVAVpBBpJIEbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 16:54:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9564.010; Thu, 29 Jan 2026
 16:54:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, Tim Small
	<tim@buttersideup.com>, Andrew Morton <akpm@linux-foundation.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	=?utf-8?B?TWFydGluIEtlcHBsaW5nZXItTm92YWtvdmnEhw==?= <martink@posteo.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: RE: [PATCH] edac: i82443bxgx: remove driver that has been marked
 broken since 2007
Thread-Topic: [PATCH] edac: i82443bxgx: remove driver that has been marked
 broken since 2007
Thread-Index: AQHckQfZDLOas/nIjEybE6+YhxsGm7Vo95YAgABk8QA=
Date: Thu, 29 Jan 2026 16:54:22 +0000
Message-ID: <SJ1PR11MB608338017FD8E4D07F689A21FC9EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260129082937.48740-1-enelsonmoore@gmail.com>
 <20260129104838.GAaXs7BumfNkuhVovO@fat_crate.local>
In-Reply-To: <20260129104838.GAaXs7BumfNkuhVovO@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7787:EE_
x-ms-office365-filtering-correlation-id: 7b8d33d4-40c4-46d0-bfa0-08de5f570d2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VGM2OGRVaVZmRjlmSEpMNFRYd3NtZUpCMVY4bzVwdW1MVVRXdzRtU1lXNVFn?=
 =?utf-8?B?ZnRURGZTcVVzRTN0d2xnYjA1N1JCR3lBMmZQRjRFUmQweXd5TjVDcmhtUkFE?=
 =?utf-8?B?TmgwSFdVVk5MSlF4WkNxVUJlY3FpdUVDa0drb3JPdmExQ0tZMEh5eTZlemtB?=
 =?utf-8?B?a2VoUkxhZVU0cElXZzc0RnZFUWVzY25Zdmg4UEFVK0VVUWZ6V240d0l0bCtN?=
 =?utf-8?B?TjJNL2RaN0FSUHNOdUpaYmw5TTloVjhwaTdteDF6Wjg3bjhKMHgybDg5ajgz?=
 =?utf-8?B?OU9ZdThTL1QrZjVrSGtEeXdubEdFUWZQMTduRWpGdUJ3Z2JOZ2pJYkl1THox?=
 =?utf-8?B?dmN0V3BRNlFRSWRicThaRXowK2RUaC9uY2pRUXhORWx6QncrRW5wazJiWmJC?=
 =?utf-8?B?NTBlSzNKTnNDbS83SmFmTnp2YTlyMEt2dnJnb25YUXIvRXV4Ujd1MzVycjJh?=
 =?utf-8?B?d2VmMTlseGJUd0FkQkxBZFNEVmVqL25NY3AyNWlLTUZYdXRlM2xpVU9nc0dJ?=
 =?utf-8?B?bUwvdzgySGRxRnZMMWlFMm9zYlI3NkVOWHQ2a3VrbUhkMUU5KzZBcGtYU3k1?=
 =?utf-8?B?UmJEL2doNUNwRVdCY2wyaDg3TjU3eldhSDBBbSs5d2JGYnNyNnQ0RDFKeXF0?=
 =?utf-8?B?WVpzcldxd3ExdUxrWW5sMEowN21USjh6K0xWcmtwOWtudko4ejVLSUU0YTNa?=
 =?utf-8?B?RXpJNFBqREJaSHJsSllQV05rT2ZZSEFERzRiTFB6dzhOQ3hWaVRhRG40N2ZY?=
 =?utf-8?B?SEVXeG5LelFkSlQ0cEg3KzBrMnpyVW05cmZRRktQbEhwcVU0RFUvVG1uYnR3?=
 =?utf-8?B?TFB5QU5MVkFoVkd6cXdsQjdLcEVsZlBaRXNqa2hxWFpqN2lRblYxdVk0dHJF?=
 =?utf-8?B?WWpRY2wyakxoaHExNGtQZnRIZ0pyN0lxeW5hOTBKUlRMY3ovbThTMUZWQUN1?=
 =?utf-8?B?Ly9iMjhxRUZNNWtVQ3Flb2FheE03VmNXQTVFdjI4SXNQU1RQdURpK0RNeW1R?=
 =?utf-8?B?U3JLRVQxVEFhcjNpRUk1UFhIYnNyZXNqR1BScjBuOWRaZjhQWUJwUDBaUVBu?=
 =?utf-8?B?VGpRNWhPUXNma2Q5SWtOc0haKy9tK1FSdzJZeTNLNXBDeWtPaW1veGpMLzZO?=
 =?utf-8?B?dTlHczZmLzBHQmVENHdlTHExOGk0NTlCaUp0c1oyek1pMW1IeTlkbGJFNHlV?=
 =?utf-8?B?ZmlGendGQzNrUk5TZS9nUEEzcGNFejFqZU0xMnQzRk9WV1h5d3htVXl2SHVy?=
 =?utf-8?B?aHNqejJQMTlWcDlQMHR5eXlRODFtVU13bTBVbWRGTEI5emtzZThHMEE4d284?=
 =?utf-8?B?aEhlbzJEWWhVWFFEK0R6WlljaDVBTlhiS3BvVmV5ZDJhQmFrWDM1djRrU0h6?=
 =?utf-8?B?aXp6OWRTWDVPT0dsamdQeWFZRk8wdzd3YXpWTGxFeHhYbzNaNUNveTBOMlJ0?=
 =?utf-8?B?SEdMZ3o2L2wyUkZzdHVNQkx4b212OEdPa0FWNk03cEVzK1paQXpUSlJZTlpW?=
 =?utf-8?B?ci91OU54RWYzbHQyTkhBYWYwQ3ZWWjJiMWRKQkdobnQ2R3liMVZpcWZYMmt0?=
 =?utf-8?B?S1V0SmJ4UTM3RE9LSlhpUDlNTVJYbzdIMkxQaHpvdVBzYnlueVJja21VQm9a?=
 =?utf-8?B?b0h0bXZYTEJhd2laRDZUMm43L2ZUWjh4V1ZhVUhWSG1Vd0ZHM0xrQk5UVGpS?=
 =?utf-8?B?MDZvYlE5U3NKS2xzdUJYS1NWdlJQWVFpYmhlYjZhc1dJUzB6Wms0RUZMZTZJ?=
 =?utf-8?B?amEydzR3dkkxVExmK2VSdWRKdXEvOVE2cm1udWJaUGVsMC83eitCRkxtcTds?=
 =?utf-8?B?VnhSRTRNQkhrVEt5RTU4clZkVUhYS2hYeXZETFF0MnU3UUpralVzS3l4RlVq?=
 =?utf-8?B?QjI2dzREQTBsMEx0Qi9wT2djLzB0TWYzQjg2TzM1NC9QTTRQUWcvd1p0ck4x?=
 =?utf-8?B?RnNGL0tpcktDclNjTnY0UkVUd0t1dWQxRWFpemsrMWNCUlR2WUU4SlVzbFNX?=
 =?utf-8?B?V1pjR2hHWDlNb2t0Q3MvUDl3V0k0Nzg4Rkx4UUl4R01OakNkOFlMMDRsaGdL?=
 =?utf-8?B?bnByakdUOGViYVprb2ZMNmZwc1VOWlhnL1B6RmpEYlQ2VDdIVFNhTnNoeUds?=
 =?utf-8?B?ME1DaXZVWm02SllhYTZpVk1YWVpORUlJdTNoK0xMem0weHova2NDRm8yN3B2?=
 =?utf-8?Q?zPoLnikSd7UUzZUfyIwG6ts=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFrTy8xMXEyMHZscjZPbDRtREFPeGpGSjFtaVZTZzBxdjRlajI0TnV2RDBP?=
 =?utf-8?B?MUhsalQyL2pxNHJQSW1jQnlYd1FhSldsN05qYUpFWVYwZVVLUEdvd3hrM0d5?=
 =?utf-8?B?dHZpRTV5QzMzOUdxWXlBU0thNURqWE9idm5tYjVEYjEzRXpKbkVYMEM4ZVNU?=
 =?utf-8?B?U1JNTm44RjVPVThDSnU1WmNLSk5rMmhUNHdqVFd1L2Frc1hyaEthYU9rTWxa?=
 =?utf-8?B?N3NNdzQ3NWdKcUNaNWhHWnlLd1pjb1FoN3I1SEViVFVBcFNDZDlWeDdlVkZB?=
 =?utf-8?B?V04vUVFDMWVSQlRIZElwdkhLZVl6VHBiVE9GUkRiU3pabm55QXluSExCaUVQ?=
 =?utf-8?B?TDVac3RLc2Fna0JnZkNSUTRCN20rR3c1WlE3UmZ0MVJ1SFE5SFlGNmpiUUhm?=
 =?utf-8?B?Zk1aa2k4dzduQXdWc255enFycEoxdFptTXptTnc0NDJRVk5RVW51QlZ2OStC?=
 =?utf-8?B?QXNQam54TnJHeEd4OHN6QnZwUGM0aGVDc2N3M090cVNIUW5zbVFaVXpPNmQ0?=
 =?utf-8?B?YmZqSk02MC9CRmwvN21BYkg4YnE1aForYVpacEplTjVraGlHcjZRL3Fyb2I3?=
 =?utf-8?B?RzFuL3o1Q1JhaU9FSnVQV3pqVDc3WkxRaGcxdGVnY3FwZWhQUnpXT2pVWmFS?=
 =?utf-8?B?K3NMWkh2VktVU2dWVHV6dnpJakF1VHI0S2IwMWVCSTYrU3gvcG8wQjZRcFRH?=
 =?utf-8?B?N1JQY3B3L2ZwYWxENXBPVDJRdzcwQ0xsZFZqTDcwamhRSUxCQmV5ejl6aUIv?=
 =?utf-8?B?dlQyM2FWQkdCMXBnMUR5VzZrSVkrcHU1d1k1eUpnb1djVGtRS2VwdE5jNXBj?=
 =?utf-8?B?WG1zaTRkdXdrNTk2aDlBOGF6WVRnUXIrcDRjZXZhMVhPeUxYellXQWdlbFZB?=
 =?utf-8?B?eEZQalNYQW1zY2VnbkJhaXRwc1VGcllRZnVtbCtLT0tld2NhSnViaDU5NlRm?=
 =?utf-8?B?NWt5dGdObmIzbW93c0dscGszd25VckM0aXlzWHVJd2hWRlpKMVorcmdGa2Fs?=
 =?utf-8?B?RzlvM2drSEtYM2V3RkFOMTZEcmJ4amRGWWhHbU00TmJpOXpQNmZPU2lGRUx5?=
 =?utf-8?B?dGk2V0ZQY1dSZVZYaElERnRSVStqa2tGbk5ZcXBIM1BrN0h3eXJTSVdmc0s0?=
 =?utf-8?B?U0UxMy9KU2hBWXQvZjN2MlBUajk1R1ZKV2Ria3gzUWNXYTZVbzN1NENHNU1p?=
 =?utf-8?B?L2pQbEZNMndaU1RaZ3pOSVNaSjJyMUNjY3FteFpBbHJKNzV1UzRBU2pLbXRa?=
 =?utf-8?B?cWQyTWhFUUFyeEErQzhjcjBsc1B1ZkV0ZTZXbnkwdGdiaC8rdUpZYjliRjZS?=
 =?utf-8?B?ZjNtc2c5c0ovOEVYS2xXRmFKaUFSSXlwT2k0Sk0yZkd1SWxZaVFTbkNhaW1E?=
 =?utf-8?B?OWo4YkIza1N4VG5uU1hOSVVGYjdXY3NDYzNwZ3pJSjgzQ0xKWGlLY1g3ZEgv?=
 =?utf-8?B?ZXd6VDFUZ3NnR011eW1ST2NBeWh2OXlVdkgrN2FVNmI4U0NMUUZXOTc5NXdm?=
 =?utf-8?B?MFJEZWwranZPeU1yQmNEMVFvMDU0OHM3aE13THJFQXZjVlJuZVMwTFZobWhz?=
 =?utf-8?B?b2kxcFY0YXYzdTA2RXVMcmxsUm5rZ2hHbzB6U1hEdHJQZ0U1dEhmQVgwT3NK?=
 =?utf-8?B?QzlJMDdobmwyVGZUL29ySVJHR2p4N21QamVYaDY4LzI4VEFBYUNjTDZkZFNq?=
 =?utf-8?B?U0tOZGVBekxVR2FZSkI1amx1L1h2bDZaZTlnRVVCME5wSlN5ZnFnbElOeEox?=
 =?utf-8?B?eWlUQkFIMUFxUGJWRVgxUzhtL2g4U3gyek1EWW9iY1ZISTYxRUZlek96azQ3?=
 =?utf-8?B?OUFIYjY0ZjJUNktHbXllQVRuTHNwdDVYUGhxNjgrbjJOWGJKcXRhNTRCZ3hr?=
 =?utf-8?B?VEUrNklYR3lORGU4RWJzeFhSTUQrQ3JxWUNKOUhpSmpKQ0l5VG12a09YbWl5?=
 =?utf-8?B?dUZHTjN2OTczTm1rUVJZUWJYalFNUjU3N0hZWmlScG1aYlVhckRoZW9tT3Iv?=
 =?utf-8?B?ZHE2c1lPYkZZUHI0a2lIdFpha0JudUhGdjhTR2dOdVhPTFRHWFNPV2VjTmo4?=
 =?utf-8?B?bU1PRGp2Y2ZJemVBL2FwVnlyMzNFbHJTUlVaY1NxdTRXOXVnS1ptQVRQQlN5?=
 =?utf-8?B?Y1hVZmtSK25SeHZJc1VyV1pzeUFHUkpkeSszVUpZWHdrdzZFelg5V3ZBSWNu?=
 =?utf-8?B?ejY4SEZCRzFJZi83a3RhYjdkd2d5WmVoNUFIcFRPbytMTXZXdzJsdVE4OVlk?=
 =?utf-8?B?eWRYNWJRUmJUQVV1c1lKU3JzMkpURkV2UkttM21vQURiYituVVZnc013cm5p?=
 =?utf-8?Q?B3sGrwJS4GLDordSgV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8d33d4-40c4-46d0-bfa0-08de5f570d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 16:54:22.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8zVC2akhdECaYkLoolJlQGa8+uRgYq9MB9ikoARj5tx/ue/zC8/7hj/cZqwVERlffiuyBee8OCxiz8nK1jirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5686-lists,linux-edac=lfdr.de];
	FREEMAIL_TO(0.00)[alien8.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tony.luck@intel.com,linux-edac@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B415AB28C6
X-Rspamd-Action: no action

PiBJIGNvdWxkbid0IGNhcmUgbGVzcyBhYm91dCBzdXBwb3J0aW5nIGEgY2hpcHNldCBpbiBQZW50
aXVtIElJIG9yIElJSS4NCj4NCj4gVG9ueT8NCg0KTm9yIG1lLg0KDQpWZXJ5IG9sZCBzeXN0ZW1z
IChwcmlvciB0byBTYW5keWJyaWRnZSBYZW9uKSBoYWQgRURBQyBkcml2ZXJzIHdyaXR0ZW4gYnkN
CmNvbW11bml0eSAobW9zdGx5IEhQQyBmb2xrcyAtIHRoZXkgY2FsbGVkIGl0ICJwcm9qZWN0IGJs
dWVzbW9rZSIpLg0KDQpJbnRlbCBiZWdhbiB0YWtpbmcgYW4gaW50ZXJlc3Qgc3RhcnRpbmcgd2l0
aCBzYl9lZGFjLmMNCg0KLVRvbnkNCg==

