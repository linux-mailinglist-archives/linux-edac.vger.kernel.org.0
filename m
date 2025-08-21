Return-Path: <linux-edac+bounces-4632-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B9B2FFD5
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8465B6869EA
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D42DA740;
	Thu, 21 Aug 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0rSs6mR"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B43D2E1F1B;
	Thu, 21 Aug 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792998; cv=fail; b=dA5J+fvSGx187trIuouMSfDPAyehLx+pfNlhqV+/BFXufab9WOLUfy78rE9RI1LnQALx8ZdgOC7s3xTgMA2y/LfxnRsxqxlSg9eT2NIZXNHBrzgtWPfsYC0oa5qz8iPIOsdBn8NM8Tmf+HkL/2uq3zMKQXztEn69ERBTvCeF45c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792998; c=relaxed/simple;
	bh=icTmIeVD0C9sVdm9PF6FtnQg43Dpo5UnSkBzZjygx3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrnSITn4qsBzB/o6RnOGe2zCM/ysKy/NKb0fwPLIpi8ZYwE22B6BRPrLjd2YipZkZbGbylRJk1/9JX0XdQC/TxwXY9Ybv6GbHeAF9p//ZHFKr0ehVmqsh+Hpwf4piBF7ul2L8mlXzyFLbJIUsWowIoFrgSGiHWwUFAsxsPmKPMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0rSs6mR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755792996; x=1787328996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=icTmIeVD0C9sVdm9PF6FtnQg43Dpo5UnSkBzZjygx3M=;
  b=H0rSs6mR3zZD95mr95hp3i9YbL85RtDMXyuonJ1evPhYxO5zK0Goxh/r
   dEnnqkgoNmrg77kEP/CEM+iVC2wi6kfBB/6fXRnt8RnwwayxtnMAF1ZRD
   SYowulmc8TFCFsu7o3QxeGnvZLCcY/rAzT7OvwBWmq8BDXBQQHOa65Usf
   o+ADB1j8mCg1fir/+4ESYFiD3DSgZ5wFEyjYQ+tYiktiJfpv656i9wZLx
   d7zwcFFTAFKos+AqxYb5lYd7PTLRWzmsiB/f0GMohGxCcHnQraxxqvjrq
   aEhWOv1g7SVWxRhHZxPrJpW8aX51syiJbVDKyP/M3wX+8nn2gbtPLZEya
   g==;
X-CSE-ConnectionGUID: hYyhHepTS+aJ28r/Z/RG2g==
X-CSE-MsgGUID: U8m57NE6QeWr3iO30m3s0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57292533"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57292533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:16:34 -0700
X-CSE-ConnectionGUID: bypCkVodQPCg6oB8ZIZWGA==
X-CSE-MsgGUID: 8uYJFSneT/GSX5L34OZxhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199433388"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:16:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:16:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 09:16:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.69)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXGnySUwNXpAkAuC2tqItAUs4TmPhu1la8IQAAjV0gMTN3oXn2kHDBmpubS9ry4TugAwbooJEb2RiX0w+tl1UnNVFlvWWBkSz7nXugZZLTaywEq+vIrJFK7CNU7E4305pTsnC1cOXrxSVwj30dHSmNg1sUrMKhvWwvg8MBe7SPABudg2xpCJNw9VNpAbH2cm9atcIX+5HpkkSJ4oAJqhOupK/HTAaeTvplJmCJLAQ3LeB57AXkI1fYMHBjVGthnRlDcDYYN+HZ8IDpfLWnqR1AeAtl39MW7MsEqwcWXht63jvVPk7UYKaQiHbsIloMaNV5pN2USvsmQjZi/vbc3zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90iHoHpsmAJ3KNgVfADeV+W0W/YRFrckSP/XbXu6U4U=;
 b=nIRvd7Sr1ufh37pqpcD3lnUvZoSKJrcQpxlhw9Z10swsjxO1P8+iVS9iR2baEvl8ZCneVQnrRs5DVHVFmAUGEw/RKKJbMRHMoGoQacBkZDbU3QiSBSPowEoUD4r9oiyE68aoZKlkJA5VTHYZztrUyO3eSJyfMrya0+jGsRPc1zkgxJPp8GBHWNLHP0o+oMC5kJZA3WJhgw0vMnxZLAZ1BSyd/riKJUu+0auDWe7tusNxMe+Q+8xcaaZ9KBpEliUow/v7IF1fxXLipC6RCk6wOcj30imHV4K++VrpNFPkQui3rgiURQn11H7wGrYCVDeLWnCHg/u6zPhMEnsEj9+L4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 DS4PPF890B596B9.namprd11.prod.outlook.com (2603:10b6:f:fc02::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 16:16:03 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.9031.026; Thu, 21 Aug 2025
 16:16:02 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mike Rapoport
	<rppt@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, Somasundaram A
	<somasundaram.a@hpe.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Thread-Topic: [PATCH v11 1/3] mm: Add support to retrieve physical address
 range of memory from the node ID
Thread-Index: AQHcESn3TJO6i8hFeEifMu3KV8GZz7RrJ1KAgAAWWoCAABKdAIAAddkAgAENa4CAAHSRkA==
Date: Thu, 21 Aug 2025 16:16:02 +0000
Message-ID: <DS7PR11MB6077843C9E2FFA811971BAA7FC32A@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250812142616.2330-1-shiju.jose@huawei.com>
	<20250812142616.2330-2-shiju.jose@huawei.com>
	<20250819175420.00007ce6@huawei.com>	<aKV6dVkPiBPw595T@kernel.org>
	<20250820095413.00003bd7@huawei.com>
	<964fc2721fb7499daa5f49eddfed54ff@huawei.com>	<aKX_rk0DasbDgJrS@kernel.org>
 <20250821100655.00003942@huawei.com>
In-Reply-To: <20250821100655.00003942@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|DS4PPF890B596B9:EE_
x-ms-office365-filtering-correlation-id: b5ab5403-601b-4403-dd36-08dde0ce05cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NICqgt9aA1TOFybeeKu82OVvxhOMt6pwSF5YgEWBwxz6u4z4wEql0xrdCkRh?=
 =?us-ascii?Q?hoBi6FI6eUQbDmTQvl3dpqMYPJ6+13NugyUWVGVYu9w/JxRwETdOoz4wC3Ku?=
 =?us-ascii?Q?KuBznpwFl7dzkldbK5kWO6n8MQHc+hi6HrsBSNZzKpzcyWgMQKQwXTdeLfYk?=
 =?us-ascii?Q?7Y9hHQ9kHVTAIbGJVMfvDckfSFZzDrGqNnGpTTbmnf9iUciSDkl39SF2Y/mL?=
 =?us-ascii?Q?dSkp7wFu/riVR3kPJeGriYHhsHTOIzP23IAlhUnXc/IChQTkf3aI7rysTlkM?=
 =?us-ascii?Q?IHF3sA3BwKUqjxAQhmr7ZXbHVjpuLNx8eCtI70cJPovnWJbqLp4D6LES1U9r?=
 =?us-ascii?Q?/5OV8MJZjDy0e0//WRk/e3SRVBAxAFiC7wD7Kb+YO07gN7JQ1Fpp2he8nPvy?=
 =?us-ascii?Q?1yL7T5tBFRxHmMniOQsY+F5i98slEIwxJcm37pZkv+/cEAHYaczECv5BTueL?=
 =?us-ascii?Q?9cqRYBtZC+EKKIBNL/a/RDzSYb+IsXQYJ9/vVpJHjcI1nOq/TePeOofpJSJi?=
 =?us-ascii?Q?+9YeRe0b0fX5UHH+USUQSs+6GxG6lwKOW5hg3vepc4r2bsE0QTWo9eSfhg35?=
 =?us-ascii?Q?SfRiXr0lnWDena+jm4OBdMTAPbFgm4/ShFCkVhtAts3HU4nXxbBVZnvExA1x?=
 =?us-ascii?Q?0FjWwql2xHDSRQ1lQfXy0CRGhCYfQlIE7ixIzbY43RM11WqVmQSKKOcvG3V9?=
 =?us-ascii?Q?D8PI8YbLHtj0albz0aKqH44f8LCQgB8qhz9EOyOBg2qQcEdjmCEVo36PvdpA?=
 =?us-ascii?Q?PD7LHAXIIxMOd+OXwB4EdDkNCRslmcLWr7E8RlPpwao8EJft0abPobDGsR3C?=
 =?us-ascii?Q?K0ErRCO9+KXyBDlzR5a9EmvRxekigVg5aOb100yn6VNx24YymhP166009Z3a?=
 =?us-ascii?Q?0rXfb0cI4SoEM4UoqHdNciEjGRW9lcr+YrWPikJG2wKYw7KLdTwjNdh8Q6Kt?=
 =?us-ascii?Q?IMlN/WE9td1pESajFcxVIvQHedCN05r/1ZiOxivaOkpKLiRtDHLRwTJl+cw5?=
 =?us-ascii?Q?oIS0c/QggEvwQ0cXRG+WywWYMcdNJid0iUy6DxWrptzk95XmPPWR1dlaGYiB?=
 =?us-ascii?Q?Lh0XAkg/OaYtGpHeZw9XS0LHZ8HkDBYfrSfLJNboTwjOqaLYwo5tieKE8o68?=
 =?us-ascii?Q?MfueSEXIRzONVxvHgyR07/QEZzcTSDDJigvQnsq/eZFvuQb9KsjvmEemR0eu?=
 =?us-ascii?Q?RLQDKXCNxfTaNeFPxEAqY058ryZavI34KkBpMZ/M5NLQLwieadl/XPcn7cSG?=
 =?us-ascii?Q?WxF4FVhoW7rd26LRNT/0znLM8KMbEgh2ipX/a937QHtn4XlnS2PpvCLr/DXP?=
 =?us-ascii?Q?kYHZR6pHa3Evk/kix9R8CBgISe6V3+pXUcshxIiYNRW+r4mc/P0zq5/S2OQ+?=
 =?us-ascii?Q?R3PbYc65iLUl1rqQI6QXLzyMIDSBZQvnvCIof6zUG94D2EwP9dxC0/pv8TFg?=
 =?us-ascii?Q?zGaicFN0gXtmymc8PePoAWwmeRFrxywCt2ThHbD3DuR7ijyKBm7Yww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kcSISV5xXkl8fw3U2F/QderJlTP9P6Dkxd9bI+Aqot0sEc8TFAt7LS8gYhDm?=
 =?us-ascii?Q?buS8sJpsq2wwFB+voloIF98JqqudM3sUscoqbeRgrmTtTkLutZOBBDIoh8wq?=
 =?us-ascii?Q?hCCuuMXn058DB2JAtQgDE5HlzXSAWJlQ9LcNdOHFMmDnvmo3adhsLOS0gTXB?=
 =?us-ascii?Q?T+DqOBRKNBz9k0s+MthFrdsYbJHWPnmyBLjFZvl1vF3kH+MaDZiPjQy+ZmkV?=
 =?us-ascii?Q?+LSMMGLD9y0/jgrZHNDJ9cZ85uTWqRxQcADvexjUrMO8BnZjcUYE8G3iVqK2?=
 =?us-ascii?Q?ANbzNPLl7r4vwPFXQQ2x9KwGCzeF8xKNxoBYxdNB6LNr4puauo1bRFOGWBdp?=
 =?us-ascii?Q?qu5ZWpgx1e1z3qdAj2TTL4zmA5tmeJ+EMcwxy2+pBH9yvcxJ8KnPOvJhDj+j?=
 =?us-ascii?Q?zfSJpM+vF9GXiPDxsUlGuz5rdLbAB2uGVvrkCHJJ+WTf5GFBRLSBgFAs06ru?=
 =?us-ascii?Q?9gDTH/x4rx70yzOKkuqWjOF59T7ba7ycsk72d82TUv1eB3V2U8BCs+GNJWBZ?=
 =?us-ascii?Q?60UpvimKBy+MzHYzuPySgJBD2hW+uYhaeTkcmTxyT1SLw8r7hiwPGRQEquQW?=
 =?us-ascii?Q?vdNn/Cvlouiiw8sRLiou+e+ZIpjSoB27K69ENefezktSZADKPVn4rQ3EM7+m?=
 =?us-ascii?Q?fOQ6gQzmXQpX+HBqUbGD+7H6lc9js3ikHdbp0CbgdGFnduCYpChDXwOUAm/v?=
 =?us-ascii?Q?VxZONTRhVKo8WbMQFbksTM5y6cMkLea0yaQ77g92HOqtdVySXTbStgUIyulr?=
 =?us-ascii?Q?JC95y8lYXa5vC5kFv7AIc6rB+IKL9RIf80T3Y0VBgPWPEF5yEtdQrHpNSisp?=
 =?us-ascii?Q?5CAPE9/PI3AeA9Cd3wr+w5OoAFZo90Lsja24Ns1w6XVkP4PWrNHABS5BvnnU?=
 =?us-ascii?Q?RmIeZ7E7SyiIrMvHc8JRqNxlValO10DuxsjgaxXnv5x2ElsKPNUVXlMFxe6o?=
 =?us-ascii?Q?6otk9pT0DW7dJBOSFyR5xkkDT3Br0Ajr13aTrAbBN/gBGM+/tTRfgok5x+8i?=
 =?us-ascii?Q?I8pHYMIWbW0X7OOT8w6e37QZ7REXPHYEPPskW027swmDJT2ltvDBGpy+P2un?=
 =?us-ascii?Q?7QgdwCid0YLMJ1uwdk4bq4F39pLhes2ZsVBWMXvfSvhkMUDlKSQr8aM7DhDK?=
 =?us-ascii?Q?OVMVzyZ0DhszBIMWKtJU9MSA677j+FR8YzD9biF9mOd4rIeccWD8RXotbf+l?=
 =?us-ascii?Q?F0BjPKm+qVyQLRHD+XykYDaASSYGqvput2m7SbuPPRg3HzgzpSIxgF6Q8nrF?=
 =?us-ascii?Q?XM6UkACj3WvBK8MeI7t1hTizr1NINkDAuaWDjAVQQjEJhKy2iUI8OSeWyZLP?=
 =?us-ascii?Q?ZJzAc5/yMd8T7YgT01jMmQ+b0fUHDW2qzZ921EmnyujJ75sQcBsQkezn2OWA?=
 =?us-ascii?Q?K09YcTxGkL+/VeM4JwBz1Eu3bsC3ffM+qUCwxjUSvUgohB8XCZwaLzbsJXh0?=
 =?us-ascii?Q?zEYG9BDlsJaIsBE/9yx1x6XEKKIDIiqwkhtcPi7OtWBSeHh1d9cZsI7W1vzw?=
 =?us-ascii?Q?63iuab9U0OQjyare2Kg6rElXC/IC99VKEf6x1ndQPsbOpTCT5YE4SXcdt/MX?=
 =?us-ascii?Q?iYtYs3paADgmuQ16ojpnaQRxbnjJ/Hd4DFbCKzyX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ab5403-601b-4403-dd36-08dde0ce05cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 16:16:02.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeD9YsVBpbWE8y+F2Ygoh2zRljIY38O2dUYcysmbEOrS+E4Eo3wFi3ptgeaBStKyzCpx59L4dkpAvx6fpGagfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF890B596B9
X-OriginatorOrg: intel.com

> > I believe that's because on x86 the node 0 is really scrambled because =
of
> > e820/efi reservations that never make it to memblock.
>
> Fun question of whether we should take any notice of those.
> Would depend on whether anyone's scrub firmware gets confused if we scrub
> them and they aren't backed by memory.  If they are we can rely on system
> constraints refusing to scrub that stuff at an 'unsafe' level and if we
> set it higher than it otherwise would be only possibility is we see earli=
er
> error detections in those and have to deal with them.

Yes. On x86 the physical memory map below 4GB is a bunch of address
ranges with varying properties:

1) There's the "low" MMIO region (often 2G to very nearly 4G) where 32-bit
   PCI devices have device BAR ranges mapped. Some of this isn't memory
   at all. It's device registers that may have side effects when read. I do=
n't think
   the x86 patrol scrubbers can access this at all.
2) There's EFI allocated memory that is accessible to the OS (e.g. ACPI tab=
les)
3) There's BIOS protected memory for use by SMI that the OS can't access at=
 all
4) There are ranges listed in E820 or efi_memory_map that are usable by OS.

What is the use case for OS control of the patrol scrubbers?

While you might want to specifically scrub some range to make sure there
are no lurking problems before allocating to some important process/guest,
I'd expect that you'd want to make sure that types 2 & 3 listed above still
get a periodic scan to clean up single bit errors.

-Tony

