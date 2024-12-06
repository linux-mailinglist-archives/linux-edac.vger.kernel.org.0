Return-Path: <linux-edac+bounces-2672-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5409E7AF3
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 22:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE2918894DE
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313E206283;
	Fri,  6 Dec 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnHlgynW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FA20627C;
	Fri,  6 Dec 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520276; cv=fail; b=CBAuu4x1WI8qFckKNdLSFwqU6eMCDvFqdxnfPrF3I3i10KCRju0kWxVsud1Qf/iCow1mzaVmYbBWqZ0JWtMxnUQkNlqBCSplCdZLnhL9lu0ngS0mWrSEczhuEMcq0idSrJ1rwC+LDGsYXdt0WhOLU7/VUuVoaL3IstJPXr1jLog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520276; c=relaxed/simple;
	bh=qJtQ/R4YHYVpo/id06t6DvdyU5/gsPV0qz8MQ4dxRAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5el5rm1k9NE9ouBq7elKuOlPPvNSrQM5PJFEOCrlvefwfxVPZhQzy5v4FBZaFYmta3fqpcO4OZcFzMM9oVCD5Vt5DUp1fyJPgFqRt6O3uwhQYaXuDJApvbmLyzcVhiJjYBNkHSRcUN9K50T6CxeyDtmUzu5RGZp63+h7X5Vz0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnHlgynW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733520274; x=1765056274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJtQ/R4YHYVpo/id06t6DvdyU5/gsPV0qz8MQ4dxRAI=;
  b=YnHlgynWsmUgkCeMPkm/wnXkXz+1Olk+29pRNydUnaNLD6TJUVsKp5oc
   tVP2vSg+KUbbm5WmeMfCcMmu1wAllW1tFLfqllDmYzXCwC3I/BYaNXtcn
   8ixCg0eKP9bMxfhb0BEL3ytN7nV/Z3SJph07HwPpjqmn9WAfwLE8zfXRm
   JHW3IYbdn1j4KVvM48W7+QWjeuA6b3Yu+mQTHudnO9AP36EtHb6QxZDpr
   4CVwnt8jzOcZ//D0rQeup7CqK+8VeLiV96p9CXf2zRrIGWUoehzzCDwF6
   uB4+Q4j50KhsfISB3ZeirWvEnCcL9jwcmqjxkPXonylIXO7eyLdrGndUu
   Q==;
X-CSE-ConnectionGUID: D1eOEd5VRuSan0c7QFb8WQ==
X-CSE-MsgGUID: h1sWINOGROKD5beuoFuPeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37564867"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="37564867"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:24:33 -0800
X-CSE-ConnectionGUID: nCNxZB3wRDOp896xwKe7xg==
X-CSE-MsgGUID: VATrgNvjRcCRawIU4tSXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94964437"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 13:24:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 13:24:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 13:24:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:24:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTHJaJIIl83vIsGvQgH37NUEO6NluBLKfQOWMaD0EWw3CbP9XCK9Lwo05SUYGjuYJ6ABA0idYyaiFlm/bd7lUf7mR7ovfy0JihS5A1UAZ8XgWxvj9K6OY59/CDjNZRE7vWWNcQTl07lsbKrQCEfb4wxX9fIIwf0N05eLDvc2z6xqSbBxVHYWt0Ym62u2yuou+IXX3WZ9wNjq+GjPTEiQoWlQ/7CWeXR0V25Bz5bXtYZgAd3xBEUBxArlSdjm1hhbuVw/brS/3NxXiO965imkYHCwv74MDiRMoHEjEB73HYRVrMPATNGMNVgPAokJEwSsrYOIKCgJDOVWLFF1SR8Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJtQ/R4YHYVpo/id06t6DvdyU5/gsPV0qz8MQ4dxRAI=;
 b=BMMX+1VsWmjgOvuC0FJoK0QdtV+uPsGe+RAMs6vm4N6Rj9kRNmH9rw1e8ACcqxcZsWEfPamHZ+mZXSs05YH9Cd8s5rfmkgVZYmXocr1GiNevlkRHVIYypuYPcAu5CQcs3Z4J2IBy+YXmdyoTa8a/abtxi4gcPLFkiK5uBeh+Nq/gu/5mnYk63Fif4nkAKfAFCEGBBtIqYoYdEy2DCekMCPuLzQ31sJx3UI0gy6DLZeKCLf3NWl3AOl0NSDMYeDztTqcpIPkCBCThOBys8RUzQ2YCiMpGaPgWIZF//KF7cTfjvQawEuNss7xtONzs/qKPUA+Lr4TqU1AnRzYlE/LWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 21:24:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 21:24:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Topic: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Index: AQHbRzdYr6wewCl8WUSfAZZpbFHGCbLYE+DsgABRaYaAAAfzAIAAEs4AgAE5QuA=
Date: Fri, 6 Dec 2024 21:24:29 +0000
Message-ID: <SJ1PR11MB60835F7CA3BB0430A4B116C0FC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3> <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3> <Z1I-A0Rhc8AHhvtw@agluck-desk3>
 <Z1JL7fevweCQtTnT@hpe.com>
 <CY8PR11MB7134E24098C6E16E43C57EAA89312@CY8PR11MB7134.namprd11.prod.outlook.com>
 <Z1Jieg7ACUMZLsF-@hpe.com>
In-Reply-To: <Z1Jieg7ACUMZLsF-@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8416:EE_
x-ms-office365-filtering-correlation-id: 3b2be5e8-b10c-4813-dd37-08dd163c5e3b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RPZs7/PqrxP60piQzWTpA7RTD03obmfUsTILPf4neiDKlSuF3W8vDluhKrR1?=
 =?us-ascii?Q?qbnLrDkayGZZiibWARAzrA9XtvpYaVP14pRorLxvrWtfGSd3HaWZjBWJ2MSG?=
 =?us-ascii?Q?WZ53geVbc6wD9i5pJQNvQit7ELA5GbqA1qC/vvlLzyxSaMWl0N5TI1dFRjlD?=
 =?us-ascii?Q?DEpNmAk6A3Ajyq3tTPud3fLS4r7e/woU0upoEMyCdWrPb40rPOlP9gHvNtUs?=
 =?us-ascii?Q?XPA9wq3EZGpb7fTxjjGcfmJ6UBXXduuPdQx3lp6lgVPSYcbnOCeDHy9kS5Qt?=
 =?us-ascii?Q?SCfbfeMvpfCH9jlATTwQb9YoH6JECNjCxm3RrXRPRoIFVxXfgj2VsGUkLQ9z?=
 =?us-ascii?Q?Tv1Z13f7SZIjYOxJcucSzcVE+DaHbnxDQTihX0s8iZ1tPKMafx8eXiMd5t7B?=
 =?us-ascii?Q?5LqMTpX9aGWSicIib63mo6aqqsXwLB8Gfo423ol9rUTeZWJ/fV87U2UP0SDS?=
 =?us-ascii?Q?NkGSRmGkjf6JVV44sRnGIQSEIopEjuOf8YC8aqrUzM2dL4JjCibc3xKR4vDb?=
 =?us-ascii?Q?0N3FXPQpMTPuC0nJx4jxHrItGDKcGfxUEdC/wg7ucuxB7EFLFO7rp5IXFb80?=
 =?us-ascii?Q?+15chhJUedRETZ0YoWdXGKNjRAwNbjPFOM4wW5/P6px/AuGE2PP0gi3elXOC?=
 =?us-ascii?Q?VZwCwtGRykPGGLlbpdM4r9ikFOkL+P8oZwI2wlt5zsNqYbkD/VmttA02+baM?=
 =?us-ascii?Q?ps6CbC96ggyp2veDJhsGNm4N7pVubS1KmTcvRVOxNMBWHu3rdEiOm3OhAN/z?=
 =?us-ascii?Q?kiZ8fFhDeunihJ6A8JmrdHcqTjmoDi2O/kpvwcIozN5excHbC3YgCc+o8jNg?=
 =?us-ascii?Q?0lA24Wjw5DDeuDHWPEdhwKTVeNAMYUTNgZsYhyP6JIzvSDEZaPl3jBDXVKCv?=
 =?us-ascii?Q?Wj1TeY5TO71X4KMq4qPJxshBwUe9pHE6tTyYP+1gAq6/wZmKA/1B5Eph92yL?=
 =?us-ascii?Q?muZXIC8n6rmvyalD20kW9Tgioqp38gmbKMYWLHDkxdQhC9Bu+ry+bb5sqho1?=
 =?us-ascii?Q?x+DV/YNsl6WSfzMifG4sc4pqReEfTK4D53X/zx/A6InZSLzIoCfiXI+EYiQt?=
 =?us-ascii?Q?38JB9miw9DW0H8oQd7zzXruUx1Uc8sDqdEoMQYWn2tNBOr+sPKygY8lV+JLH?=
 =?us-ascii?Q?cX5uFFc2wHPUrr4j0gBwFfyEkYqJT3ehmbMhb0FYmzpT52P22jSfSgtEAFSM?=
 =?us-ascii?Q?BfxLI71c2ve+5bG94cuZT+Z5WijXWaAI8FPRSAPuauRa3f4RBqW5jckk58W+?=
 =?us-ascii?Q?Gln64kNRttprR1KLVDEj9KVJnkoJcQj99D7qAPWE6oqlqVkJFE1Neeu4Po3F?=
 =?us-ascii?Q?L+HcXlXQlEz6vJ95ILmR0j9Kj0UdbSwVkNV2l3zTCMmqiuZld+JJ9MnI0kvQ?=
 =?us-ascii?Q?jBGFQbYcjLz+iz1aCW+M2GXeOXuueuIHIkqxSxw3ycawp+ysmA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pOJZ+HD0OvfFhRBNGb5cR5x8a/7UBbsO6KXz5tN6HezkkvWkVOdbCcL5+uHh?=
 =?us-ascii?Q?sU01QJHIx8Pkcft/CKVtS40RvZ9LAhfBqqozE/fE8sfEz1rpDZjM2xja+45E?=
 =?us-ascii?Q?e8RK1FPOuGg0rAYb45DIY2w30dzu8sI5LmMrVEwqMPUofSJlFocwAP8UnhIf?=
 =?us-ascii?Q?5Ssam3TN47/cYKjdL4AK+5OL2kTkOE1PFAwbiHs3G0c1tTl7cCU4SGhPgjAV?=
 =?us-ascii?Q?pqf0psd7bhOMg8Tue8JbPWTWCY8ZUDgxntZKtZ75Zhc73flDkjFzGhxp6bLb?=
 =?us-ascii?Q?Dcd5wletR87Tbzz1H72MDW87h7CT2Ea6/Fa3wfEEx+I552mj0ye9UFhtFXuI?=
 =?us-ascii?Q?gtXA9HsJ6MVgExH2WKGk2VGdOJIg3K8Bn7Q1b76AU+K2iXhT+fnvvZ5wHwu0?=
 =?us-ascii?Q?ZCt7MscNJ8MAmJBAkyb9veGo7BNVY8PuKBn1Wh2Joz66ltYK6VmW4bNUjm5N?=
 =?us-ascii?Q?6gswJSRtf8JIgXisxaPg1bTJLN1+12/s1ZEsKdtzjuifAnwNUpDMowzO8dN8?=
 =?us-ascii?Q?rwkhio8PVaQMsNTjDt9tOxitFmIgHI+CFQmNozevIYIo98Vy2mgQ4tknDRq7?=
 =?us-ascii?Q?Vzv0ICFbRyOkaWRx+1n3+CajQDmI61yZPrPk8ELthRMekz/rLd3PEpoxZmRV?=
 =?us-ascii?Q?PCInCLDSIlBR5zo4sKhiWs0eTYc2nALE6rDYfML+gMA0WNUUGseo/i8+4jwL?=
 =?us-ascii?Q?wU1PpVjImmLVHrGI1iRvIgJwkDz9Y+xltYcAJ/T1rvD7+RG9Jq598O47cHBE?=
 =?us-ascii?Q?JTT9oh33c2vS/5izrNBni8xULgWmsim4+NgaMxlF12oePFZbuVfKNoIUMCFc?=
 =?us-ascii?Q?sTXHAblBnU4sjOplmC4bEr7SZwv4X3LvI3Gk/VT6w+CTUsdfDj953B82VPmp?=
 =?us-ascii?Q?wIxrwzWHjiHnrectCcNr0Nsk2Pfp6rXGCIOq2J7KsC9eJWWu++1/jkNjeIM+?=
 =?us-ascii?Q?O/t71071adQAtXgXNebJjTTeM3F6up6FVyewpTwuEOpoPdAYs5wfLXqP5bHN?=
 =?us-ascii?Q?4kr1N/7Fa4XidG8blRxDWG/M0msU4Uuijj3EhY418Mm+zFcICeOlHWajxU3h?=
 =?us-ascii?Q?+ePj/WEWNbtgkWg73fht7LOSck9VOQP+PXTDDDWITDusDYEd4MtHz3Ij5mw5?=
 =?us-ascii?Q?Thelc+DAb8//3MvLVDefjvFM3FbP+sh6qCy43aCyGPge7KKdZeYiOdS/Uiol?=
 =?us-ascii?Q?P6/OWmxcRxcO4JrZfSbbzfvGy/40HF0rOS06/YrmJX9qqMN2R0m0xqLqRqhX?=
 =?us-ascii?Q?unTXSFPahXYPhSBjXr5I2WSCtDcnynhP6jfVBQqKI5GqrK1//nqUqMWtRtcS?=
 =?us-ascii?Q?ObJ62j0mYuWDpk5do+XdRakIVN7m3QSbThaUBt+OAb8/D3cp9QyevcYT1aYF?=
 =?us-ascii?Q?qjo0nzMkOgC/w1P8v5Xw9lFnQeOPEp3mOJA4hwGU05GpJDxbw/+6r3frxf6M?=
 =?us-ascii?Q?uWVa1v9DA2IbCb+ibq6UgD/Qib76aCxiOHdr41O94QH0I90/85qhr0JiCVlz?=
 =?us-ascii?Q?CxNhHxvqdXuzWP+0+jeCNIjyWx7ht+FaGXK0V86PdmTWMg4LFKXnWjgN53yI?=
 =?us-ascii?Q?C5rveEINFngnsP2k/QmpFhd1klcUH96n8wW9vRtm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2be5e8-b10c-4813-dd37-08dd163c5e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 21:24:29.0781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v23nEhh1+p31YLA6mtLnzAzOxtABCv7sckpqv6aYBWq5rPadaBq1uOctQpnZonTiUst0AonFuIFEvhYsgLPrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
X-OriginatorOrg: intel.com

> So, we're back to the original issue on systems with multiple UPI/QPI dom=
ains
> when NUMA is disabled.
>
> Systems with multiple UPI/QPI domains can't use source IDs to map devices
> to sockets. skx_get_src_id() will successfully read the source ID from PC=
I
> configuration space registers but it might not map to the correct socket =
because
> each UPI/QPI domain has identical repeating source IDs.
>
> For example, 8 sockets with 2 UPI/QPI domains:
>
> Socket 0 -> Source ID 0
> Socket 1 -> Source ID 1
> Socket 2 -> Source ID 2
> Socket 3 -> Source ID 3
> Socket 4 -> Source ID 0
> Socket 5 -> Source ID 1
> Socket 6 -> Source ID 2
> Socket 7 -> Source ID 3
>
> EDAC will successfully load, but it will not find the the corresponding d=
evice
> for errors on sockets 4 though 7 (for example, see skx_common.c:178).
>
> Looking at my original patch, EDAC will not load when a system has multip=
le UPI/
> QPI domains and NUMA is disabled. We fail early with "Failed to get packa=
ge ID
> from NUMA information" instead of later when an error occurs.

Looks like there are four, mostly orthogonal, configuration possibilities:

1) System: Clumps vs. no-clumps
2) BIOS: Option to pick UMA vs. NUMA description to OS
3) Kernel configuration: CONFIG_NUMA=3Dy vs. "not set"
4) Kernel x86 boot param: numa=3Doff (or noacpi,nohmat) vs. no option

Maybe not all permutations make sense? '2' and '4' may be effectively the s=
ame?

Can this be solved for systems that have clumps, but Linux is ignoring NUMA=
-ness?

-Tony

