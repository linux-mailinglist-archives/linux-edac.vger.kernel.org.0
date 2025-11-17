Return-Path: <linux-edac+bounces-5451-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A085C623DB
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 04:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18804E25EC
	for <lists+linux-edac@lfdr.de>; Mon, 17 Nov 2025 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92AB284886;
	Mon, 17 Nov 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG6vweBB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFE1B0F23
	for <linux-edac@vger.kernel.org>; Mon, 17 Nov 2025 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350028; cv=fail; b=XDVxnqsEzg1isO7nTc1QKQkssjNiY7gunx9Ajk7F+nLSKUYgR5tuZQzlKFkXGVhDtHXpJlWQw3ZD4AHHeJFLiONK0E+SXgyhhQX2pd3/v063sl8v/cfEdJgzY75NrwygWvFR1usuhnHJaDzzvxfW/N2ggsSzzQXHHMJR1eF9fiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350028; c=relaxed/simple;
	bh=SzduFr5NpcpN/M0JKvZ0EIYHizkBu08kJJdmssVVVx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okS8b+vL+EbqPi9h1t5CxdVMGiZ0cnSaoUKMxC8/qZYkchKP3kGLsXYbSx4QmsHu03OwHjsZPWlU1OOfjwZHY5gt3v2mSkNy1BckAzQhte7jOU3kIWK0DOHsAAMpbZRmffM7XNQAV0V5IkNw0UgU3FC5SkN8e72SNM2jFV60vH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG6vweBB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763350027; x=1794886027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzduFr5NpcpN/M0JKvZ0EIYHizkBu08kJJdmssVVVx4=;
  b=hG6vweBBX2138EQzxBNg5aQJvZKFg/jeKl3YppcBhHDy2vv907LplUol
   PfRABOdUZygVoaQOhTtB9QMG0UYHZI6sJpZ8LIAoGekbmy1ol74RoAldf
   9Mk+qcxfX4/SI37MlbPvMur1f92ZBuZomDjnZzldWaNo2SyDhKTQJUs1J
   2yJyl7/iWQCQsgzeb7UUEXyQAkdqAOuMv+ujW5iXjScozRPb5Dv9VnRlx
   FIqe6a91hg2w0E1TaW8Ud05YCZKNfnrjpL8D+eEqTn9inG9BBKljuTOnu
   0BoZcL9LC8LLNTpwZdBlk/Zizd3/aaSw+qAuSZj49mqPAYQs/mbe70Zf9
   Q==;
X-CSE-ConnectionGUID: GFJfLqmWR0iYaC8NzbOoKw==
X-CSE-MsgGUID: XwgMFqzgSgGPxqtlhSQCCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75946605"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="75946605"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 19:27:06 -0800
X-CSE-ConnectionGUID: 4zzkwmmQTZOzhSf7a3qEEg==
X-CSE-MsgGUID: LKcYap/HQXan77rbJkXjeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="227667008"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 19:27:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 19:27:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 19:27:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 19:27:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHLXXTGrcrLnDQkU6TrxEqKDff+xgqsSNMHfkHHUdhL124WPuce+mOVhRMH4N64/RHklj6NwSP3ALz81TBo4CAVX4S9gd65kVHVZ++YGkpJfOoTHvYFLn4v+cv97FBmvUk53edm8Ig3Pyx+Mkcr0YJ7IClGhXwQLBs500pmk3tnL6M+zmYJXUFRFRHdHiRWGvTAzo+3XlfgWk6gks/IKX+QcNa6U8nPV6zSHn6xt0BSp8Yggj5XEDxhvAXvGMhH8rSeTx8V9JwKOR9Vs9yFv4W1S9ZZNXgyp6rC/MZvdtF+J4HMu5rQbRbflBSEAy3ZhqGlWg1L/7+0uWIGxSIIAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hN44mfZzy4kC9RJx2kUazxxza9Kb3/S8laQG5snA9k=;
 b=JaRmFVWS2JeMzQR0HIKqKIVpLkSXozG/512Dg83UhrEI9kH343ZTEaZGqjpHjYOWElXsoqTM345inYko/Ez1QTjLkbyODIvyafirmSJ7i/5NCbwYLONxg3ml3/9ofMDILBJduiV9Zie17Bo891aG/w1bpdpE36HpCZDJMICjW7TbSro4Gzxf990bXNzlHKl6ajxUwP/UluDfRT/ckaXgMmClq8kEwZxKTCgpR70xVUZQ2k8Pwn4gFLYnn3cBPyQ6ziwGkyNRV/lpnd35x0UyBezIz663OW0N7Z6imgt07buL/VKxGXTZn+hDTATHvXa+lcxxp4Oz4mMKt592AFDflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 03:26:57 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 03:26:57 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "shubhrajyoti.datta@amd.com" <shubhrajyoti.datta@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2] edac: versalnet: Use kasprintf() to simplify string
 allocation.
Thread-Topic: [PATCH v2] edac: versalnet: Use kasprintf() to simplify string
 allocation.
Thread-Index: AQHcVzOUFuF8Wf4BoUWDoKappiTPNbT2MmGw
Date: Mon, 17 Nov 2025 03:26:56 +0000
Message-ID: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20251116120243.GBaRm9YwFA1cMr5zGR@fat_crate.local>
 <20251116195858.18214-1-ayaanmirzabaig85@gmail.com>
In-Reply-To: <20251116195858.18214-1-ayaanmirzabaig85@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|IA1PR11MB6267:EE_
x-ms-office365-filtering-correlation-id: 0c036d11-99cf-4359-9657-08de2589298e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?86/qlxQeU1SXX8CVd1q1Xd84QiSRJsaSIPf71li/n7PCKt/DIvpWfUIDPnVg?=
 =?us-ascii?Q?jTwFWmdgyyIyUqcDohcnzBP70PgdhSDDvxO2NuQh5yMTAwDYLOe0HYMS6UHb?=
 =?us-ascii?Q?Ca9fMS1vLm5h/L/pJZQLee2h2M8MXeZ0s28A926c+iNxkfa9KPP5DJFx1wQj?=
 =?us-ascii?Q?r7CoEMBZEK+Thf//UKPKXj9kQg8qLy9Yh2BeZ0r8Wvj8mMl0M8GmO2Iry5x3?=
 =?us-ascii?Q?v4WD5L45jx3Z/Q5HLR9m83FqxSRqs5zy88oO6GWmdvtAyGtRWHWheiVDcFDC?=
 =?us-ascii?Q?a09KZyndWyYFlEvCPMtaWrKjv/32IjVWypxPzN2ahd8KrtoKSuytaJ3Dph1E?=
 =?us-ascii?Q?h5G+9D013uPmg8bCCL3zkRclriCHXkjN3sXi0MeH7byGm8kPuIiLvDp5HbPQ?=
 =?us-ascii?Q?1i0YVok+RyYodNQFmEPp1A/83HoWLiKDA6WCAx1um2fVCXEMEOxnkHadmFXj?=
 =?us-ascii?Q?3NWXrFYcNIbKxespByjU1HRcfb0eW86d92RQUHB7A6WUMrNIX27PxZdMLWVW?=
 =?us-ascii?Q?k3mgVOUZ+adOvkcRZTQt29nVPRJoL2erFnW1aNKV4o/R50YtBWru0BvDMNYI?=
 =?us-ascii?Q?PfYts0cQ39sBTse/KYLy1BFNPk9wTFRxm9N3vVn7DxcGjuE2l/NwX8kBKr3u?=
 =?us-ascii?Q?lAfvJlTYgqKiYr1oiQ9CoRDX1j/UjbDtjeWiQXOYIVp8r23P/jivYx40Y5Bo?=
 =?us-ascii?Q?ARIrIHbvldWW3MkQ4ubqeBTDVO66YojMPBzRSfSSa9m1OLlQzlpQkwG54uJ6?=
 =?us-ascii?Q?H9rAGUOts72G/IrEClxhtOFx/4/sEdS1PR2D0rVbmqI6Qvpewv9gyV+WeWfH?=
 =?us-ascii?Q?sUDOXWMH07JNPkVyY0lJsyU5DoZ9AowiAhvRdQiHMv2sIqDKCi1uTP3DoxCZ?=
 =?us-ascii?Q?Y6rDzf1nUtNySr6GaQNSvgCbF0OMRzkuxjFlDwVtdCKR9/lWLMl70Jn5B//w?=
 =?us-ascii?Q?jIjjCVHQNEmiGd0rITJF29rB1zfliRK5jINBglGVPT2Ifvz399PzLI8SPbdm?=
 =?us-ascii?Q?rhe8b5WMVo8eH8sGOOsXT2dkcA8pjJJNPEaYqxu+4O+ASrJ91B8enTMlHmHa?=
 =?us-ascii?Q?b0KG7BIQXSGvaUApUKX4X3BuZ5p1+TANkq9fJ3nWJl4DGhHxZk5YQggAXumq?=
 =?us-ascii?Q?xNQHu5sMLe6CXKL4+DvvT3sdhwcQEMAjQFjZtrV3ZhBA5twjDIiIi4hoW1qr?=
 =?us-ascii?Q?DD4zfxP9hyTLTZ0cnKeogbQzWeUJlCYuPpA30GhLSAXlMMAEI9xiNaB4Y/q2?=
 =?us-ascii?Q?X3YQ7iki2hiyJFuVfnwPMBRu1dP3sSQjtNWcoIVHd1br8NcDfTQMmIC4Z3f1?=
 =?us-ascii?Q?nqpRBBepW/XbBHAItd58Vn+WgGfgLvRWT4q3rSYz3/lWluwug36NlqBCsQZ5?=
 =?us-ascii?Q?NS0fkEzWRXEjKYNplon1QBRsnxjOhKg3wlglZOzQO4SJ3AS0gLcJfZnq8oMx?=
 =?us-ascii?Q?FsJ5QJ/hkQrUTx7lGmCNnCt0XsNl58Om0drra+g+8SlrjuOFwpyJOoSrmxzn?=
 =?us-ascii?Q?7Ky5puQOjAySLepZgD8sgbUt1Qdz3UEZsI2s?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A8ylNRk7ePzeFVA92k7cMEmOAaQwCj9pdi/G8wFNkL0YeWbQht3Mp9H7+Lf9?=
 =?us-ascii?Q?V81YxAUN3RmJyEp8PNCUMNADuhYZUfe7ud/P1xzaigB+reRaKr42NoPCXrA/?=
 =?us-ascii?Q?qH3urP5MIqnI46OOSpW6e09H73WCcwmLjEJ59Ul7sNNhs2aSMPb+gqKbXpsu?=
 =?us-ascii?Q?XR+qsxJxwrovvYltraKjfChPB9MDEaBNmOYJ1I+WwfwanQCAqVpNOep6EicT?=
 =?us-ascii?Q?sbHh+ew+ZvVtX+o3RxJAl6hIk16ibGIwyzQdAfux5yxyQSUpBIYu1Jfq74QU?=
 =?us-ascii?Q?uCaElAFYn1dfF5OaXqAh8cFequdyxy7PoKmJjHbwAF7z/zL2ymclv9R6Ad+r?=
 =?us-ascii?Q?3yuIEig2i1xaOU3rsqTmmPQvVNEBTLnjdzezmXKGkpwZ7NIWAgVzAa2EnwAw?=
 =?us-ascii?Q?TXpsZa8w8InPcogeG5SmmLAvKKoSQLygin4250eU3vE9KV5HogkTjgOM3yU6?=
 =?us-ascii?Q?dyrvfri4TwSxyaQDxYjyrn47HFXM/F/gY9RlfOyfmCDRBc7GpLxuZoxZZdJI?=
 =?us-ascii?Q?5geypY0betfZ9+0SBkXe6NjZTOzCbxy41jdQFTzFYfRdU6r28hmNiCbO1s90?=
 =?us-ascii?Q?wrD7rJ0bYHRwjvF/fhgeU340k7sggYv3frG1751spjIBCFJ0Uw3ycoXqXVlZ?=
 =?us-ascii?Q?Pj41LPLR4CO8veaBvPS7CK19y0QIFxrnCURWM9ykLGFwRIxK3U6SNWHUNBDh?=
 =?us-ascii?Q?wxtMvoFMP+GMafMu59hlqwgr6i6UfWaaBlnWyK7XzJ4ut5K942l9J3K66bfw?=
 =?us-ascii?Q?GtTaGEEA+o868v/WrEajp4hZTwifhoXjOXvfFMPLPxfOF8B1CGIKtiFfso0h?=
 =?us-ascii?Q?x5GSteBgU3L/QiPo3SR5zpb/r1jt1OXAuPACLO3tsjlRm7WjZUSDCDf6mu+T?=
 =?us-ascii?Q?yFPmNqhwl522tLB40u8a2ix4wDqz0fz5E8wDc80qIC8WP2mkaKdJVmVZkXMG?=
 =?us-ascii?Q?d57hCWJuwpdvCYYt7xo/L+4yyEeLbGCjfkseRPQzHgwwISbZuukbqx+z8KBy?=
 =?us-ascii?Q?I5Z78IBjXEX1jBxCfhHTCbArQz9F91QbKjjfAmGYKjpHQ2iWjF8a1b/fhtnh?=
 =?us-ascii?Q?aLVpOubdvXLslYDRKyWXvFJPAhW5Er+QhwdwCwxmHk2veIkBzUuZqEd53RyY?=
 =?us-ascii?Q?W54z+aph/IUCC4x/dMDHQXpYedTL+fFq1Gh2hQR7w9YKh0HSAS31uqtK8Gp+?=
 =?us-ascii?Q?dGmhcGgknPSPntJ7s0saMkdj5uAk3gyON7yNp905+80yIaMJPCf09iqdluuw?=
 =?us-ascii?Q?J8pSZqxeS+n7mux/qdo2hlE5KHvCrZTCuj0RmgxwIsSBr+q5XUXfikbBgNy3?=
 =?us-ascii?Q?I3RhTdd/Q/MmsU8gfdlSw4QvPFCAtdpTKjW20bt7KLGxBNsvhbz2wxo7gVnt?=
 =?us-ascii?Q?BwuaXIGrF5QVDPjODCHvqw3gWj4q/oPNzfm4du5siUTqvbb5e7h0Hk1wnT72?=
 =?us-ascii?Q?1w8bg458xTsHI1qPRIz0iTJzHkS6BYy3c3SzDRhu25dxVlbo4zl9dIdW2WEO?=
 =?us-ascii?Q?cHtD9gyX1kxfStLI5o6lsdubz+eyPAIOXMYpq5GfogMgvupBe/HIZwWGvofZ?=
 =?us-ascii?Q?vhoBs0+KRbsrNLhExu9pjpuF/+qkCpDOTiJxGzBK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c036d11-99cf-4359-9657-08de2589298e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 03:26:57.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJBo0x212Tv+MJ9TItxYy5ep+UCkBobPkgMYNp+MafZP9xwOb99ud9PMzbsdM1cU4QET4dGYRyeWz0pKre78nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

> From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> Sent: Monday, November 17, 2025 3:59 AM
> To: bp@alien8.de
> Cc: shubhrajyoti.datta@amd.com; linux-edac@vger.kernel.org; Ayaan Mirza
> Baig <ayaanmirzabaig85@gmail.com>
> Subject: [PATCH v2] edac: versalnet: Use kasprintf() to simplify string
> allocation.
>=20
> Replace the kmalloc() + sprintf() pattern with a single call to kasprintf=
(). This is
> cleaner, simpler, and avoids potential buffer overflows from the fixed-si=
ze 32-
> byte allocation.
> Handle the potential NULL return from kasprintf().
>=20
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
>=20
> v2:
>  - Add NULL check for kasprintf() as requested by reviewer.
> ---
>  drivers/edac/versalnet_edac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.=
c
> index 1ded4c3f0213..69a9da8c58a3 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -812,8 +812,12 @@ static int init_versalnet(struct mc_priv *priv, stru=
ct
> platform_device *pdev)
>=20
>  		dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>  		dev->release =3D versal_edac_release;
> -		name =3D kmalloc(32, GFP_KERNEL);
> -		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> +		name =3D kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d",
> i);
> +		if (!name) {
> +			kfree(dev);
> +			return -ENOMEM;

As Boris previously suggested:

  a) On this error, it needs to go through the destroy path to clean up wha=
t has been
allocated.=20

  b) It also needs to add code to free "dev->init_name" in the destroy path=
 properly,
which was also missed in the original implementation.

> +		}
> +
>  		dev->init_name =3D name;
>  		rc =3D device_register(dev);
>  		if (rc)
> --
> 2.51.0
>=20


