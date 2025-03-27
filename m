Return-Path: <linux-edac+bounces-3408-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4CA73A30
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E25171039
	for <lists+linux-edac@lfdr.de>; Thu, 27 Mar 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CA1A8F71;
	Thu, 27 Mar 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uu+A+1ja"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35C1DFF8;
	Thu, 27 Mar 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095585; cv=fail; b=NFM5YSQnpHuvGlY05JhHxgDD4wSmXp9nNi0yQ6ziyLChMUDJUPn/xxZXoZ41xs2OytuP8HNZiofTl/VI01mwvYBLlus0IxaRFYy+eOhoxc1P8wenalaXT2mUC5z3UnEMd1dnqXGow8VlJ97xO/Xyv4AvpfosaqQ4zDlAB5wEoSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095585; c=relaxed/simple;
	bh=7Gsh+rFdsu22S3kSM0u7C4K0C7cHDMMAgePE6hriG9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VoJmYV9Ey4uIa96XzLXWG5cW3X74MCWEy8YNr7Kir1EzPpBJPKggp2ucWu1+qehq6zotZWsMbG7yrpxG5bh3JZ39ksmOim4EWml/TBbvRmNb8ycgOAxHbGScnKQ1gtnNQ3f/l+ZewF2AREIncGBEUz4xBKLRhLErIMDEbdUrHJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uu+A+1ja; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743095583; x=1774631583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7Gsh+rFdsu22S3kSM0u7C4K0C7cHDMMAgePE6hriG9k=;
  b=Uu+A+1jakMt7ENF702UeFnMA+WAGIavdoOGbeuJDJVlVxIWZalsqc13l
   AOOXwaOoGE2rF8TKoT/xEz4IdNHvFd2umpNzwYSWktJ+susaf6fh/cYt5
   UzRP/4sk0/FAoY+CDvWAuyxaZFqfwFkv6ELq3Xqz1XDF+Dc4x+Y3GTEMk
   5hpbDy3HXkA7U1Q9SGCWCPk9dfu5RDHCJ8oNcL0kvmx9gJ/68Jj7AfLK7
   BXXkG9ItFtXQGnBsmfSV5hgCIIG+AETQ9Q+xHs0nR05bNMfEuOn0whF/G
   7UJA6ysx2dekU9ElL8eNFCbq85GnuxZTrr7CgXi+rYn624gJiWb0He32X
   w==;
X-CSE-ConnectionGUID: FzMOoi+UR6GYqkeyxIyRxg==
X-CSE-MsgGUID: wK8sCi1lRteBacppU+uOOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55094028"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="55094028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:13:02 -0700
X-CSE-ConnectionGUID: GmMuuw88QSSYFOOzfkqAWA==
X-CSE-MsgGUID: DQaurto4TEqjk9kJELJexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125221144"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 10:13:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 10:13:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 10:13:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 10:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqU8l35UidruJV6aD9h4eoCB5/Pn7IXWNMt/IZaeDyvOiEG8E2J3pcltKjWuivXj2m6us8L741CZ5OeDaWcHld07BIhfMLlpqS9g9vXNGwsSMWSd38lU1r86TsVjGsN+ZqP8C2cgODTVrRirWhxekKRYT0rivck/OMk2xpqTvvRGOMqGBQQFuw/l4MLvXlYnXT7vmFmzsWqwcc+9nCeLrPbUpgUs83L95PxE0xiQ5W7059IAWfJCDphOeUfu0cg3uQxm3L/ITiGxiQjY2JCkg/RPqe+DC9lM4KXm49je/7esETalDRCXWXvO5/omePLjeU+NKms/K2Zi0gDUijacNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTJ5v/oxAIMN35FZ/6YwKqWmy2ml9hG795LC9mDwxJw=;
 b=NES05x4DrNp7jDpb+ZPWxKrS1MMozJVlQ9IcJCjiMeQui6DhZl8jKBMkxBvoINWQ/Z05zwljyDhUU3c3uXlEGvmZHo5PDUevZ+YG1h1vQulN6WTNgdA6TN7+XQ/xQDxgJNsJHr2ppaIED3WiAwbEXxeJfTaBc5ErH3N7oLMGWw+YZyQzSIb/Yd3G15MSwFJ5sb1g3+TndFfRox89MuhblsXwzi/pyBxSuON0cd/cV7ZP+TkHZtB6We58YaRsikA7HXAvoOFb8aHomk6l8qdTJF4UzlVgpfHHXnFVbD+vZJsP9Hp5Shl02mG3MC1kB/g91U6Egnv91NfT8nJJQbSX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 17:12:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:12:47 +0000
Date: Thu, 27 Mar 2025 13:12:38 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<mchehab@kernel.org>, <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
	<rientjes@google.com>, <jiaqiyan@google.com>, <Jon.Grimm@amd.com>,
	<dave.hansen@linux.intel.com>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v2 4/8] cxl/edac: Add CXL memory device ECS control
 feature
Message-ID: <67e58706459c2_13cb2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180450.539-5-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 023f7146-540b-4654-44b1-08dd6d529845
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4qWkgFAtcbR+qOAXCJuIiIF90er3kjZlSDQrooi4SXZF452Zl2ZycusBYT6I?=
 =?us-ascii?Q?Oh4tUnrhtv6QS09UKFRXvnCRshKc8MRM40HwLQQTOFt5CAibZT1YJKGT3mKf?=
 =?us-ascii?Q?QuEjfGI9RdI419hTyc73whkQK7xatnoQF52MVxuuKmLNDSpXJTXBG38BHp2I?=
 =?us-ascii?Q?ZJO2DUrvnJ0RbOMyBQHZjqMrCozH5jM/rL84p4gpZby0bieixMB61THOWkz+?=
 =?us-ascii?Q?0wEjEkRt99tpYl4NdNIFOp0/vaz8yz9C0H/jaXaovLrc6VoKmZYD7x6Uq/Nw?=
 =?us-ascii?Q?ZdGnD6PEVavhfbGoEqiqMeQ1kxcVPqeNtbeVbYj0gp14zqjts+0k+d+72Fmw?=
 =?us-ascii?Q?R5DPpMoSD65hib+omhyf9zWxlW+2Cp193tUMKIGeI6y08ZHsn0j1H99YKs9Y?=
 =?us-ascii?Q?aG5b66lZDiBIKy9SibYFUNxggkB6U5IYFLd/kBS9VxkTaNlULtTpxqcNsqAe?=
 =?us-ascii?Q?djw6TEwKGAkGvnyG2I2tYGTApf+sUmwiU8AiTRmZTdDFvQEVidhvPR6B107f?=
 =?us-ascii?Q?p+LvlqTYP/Yl0ugIMeSvwRegsNcuX9Bj9FiG/Ls4Zhe1NC5+3dDv4qk2ZQt8?=
 =?us-ascii?Q?4xHWcMRNlYwl7oxxHwIYnx8awWIIf1V627RPBqCXCtn0xcA7tPlbsr+oeVtz?=
 =?us-ascii?Q?JHWR6JhyG03dTbpu/2oP1nugN499JcQn2ERYjjmmsDprJWerxSSWXGNU2mIT?=
 =?us-ascii?Q?dIKZtx5BAMeo9QDoEgwm9B97NnqCdU8Be5L0fKlpNlQRJq0nEDwK8HvcqWbI?=
 =?us-ascii?Q?1JBDOo1WUq3ZJf/2RxzAcrQuvi+OhQ6oSpKYhn1NEy1VScj5Q439DIjnVwZd?=
 =?us-ascii?Q?YbynCFZAxEKo410JsEdmmxBi/Hqw/ZGqsRcx/1Mc7CpurV0XrSwJYGIkYHms?=
 =?us-ascii?Q?oykmhTFpsUpjkNLkR9uk69Yx75hPGBGqCg+RGk7Ny0/82oeCBx9SQ+B9zbPU?=
 =?us-ascii?Q?I8QwbJVZ11vpRBBJQKJaK+bez5Qn0xPJdLoPfERtnf24+sVTH+aK4BEJL8jW?=
 =?us-ascii?Q?RZCnH/oJBsFd1/ZmbVj85eaIKN2+dHoYfGo8p8ATibPVvKCXMdV6jSL9ahER?=
 =?us-ascii?Q?E9/vXzQ8cQYVcI9g5MKIQW3RQnITfkBUkk+/MeAFMeX/qHxvVp72wjBgTL2Q?=
 =?us-ascii?Q?Uc0rNDNaWsR0HvP8ayuVhF8Lz2dpG8xR1hTAEKQBEONMVgODjw7GiUTfEroi?=
 =?us-ascii?Q?/OoynNa3Dd8YS8ronXglsHYxtuxtzY/fx/lAKECQ8RfJKghTQ5510mhGywEE?=
 =?us-ascii?Q?zB+LNUnHJsyNzrCqxqPdB7Ewsw3wsB1uBRprEtzAc9GPYOVWiw+5f4ZuayoX?=
 =?us-ascii?Q?CDcMd9UOQW0nzWQmcPJsGlq8Lto5FyuE3a96sDH9GL/CQVd9kdbNXN4ikBOC?=
 =?us-ascii?Q?D2x0JT8wTopvfU8pN/wVtqv0VJLJxtUeOI7mTyBKRfJKcx3RnlAy+KqIiOw5?=
 =?us-ascii?Q?jN3QiIEd6aE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jmBcpgvzzaiq8UVEzQq0GVqB1X/8Tk4TsJCyb9lNO+niH8mTafFB1tgCvMw?=
 =?us-ascii?Q?Fx8tVWW7gHTbIG2EP54f423DYZQmIGpIcPnxDtXD3eLDv/eqwwvp+Vjd/s8f?=
 =?us-ascii?Q?NkT1ZytGW0VUotNfm3I3CfT2BFp+4yf2MOmoQxykoCea16euXztJKDNIkk3G?=
 =?us-ascii?Q?e9HlvhmXTxicBuIaZ0mUneKF8wXRE+9S6GFh1htB1OcOoS+gDO2GO8fvjsyk?=
 =?us-ascii?Q?JT1dbCqNdfqTpW93qBU5dFhEByqXJNH8mj47QJUiW4N1BxYqRURSZY4Y9tBz?=
 =?us-ascii?Q?9RSB6ChwJ1f8n1xZyG2Po0kltEYcrEbzwN6VJrPb5lDZFRF8UZtKBW1ZWQJK?=
 =?us-ascii?Q?877Wr8AOK6lRQflKgrftvs8a8K4RE67qn1IEnxi6aLvHGTRsxwLjrBlQjieq?=
 =?us-ascii?Q?M7ealnhq5mMwqmX1TS9cRWYmeR7uFjfokgA2RsIB27ut+m3UNG1ourkP0E7T?=
 =?us-ascii?Q?Sl+v30tNWWzBBv0yjc2OTojjits2A+aoN1yxP457bHJ8wruTVlEcitWl9RpN?=
 =?us-ascii?Q?l8K5DzP854EXF5sHiDyfEskrVmBg6VP33aBeQien8aoFbETsRXsLImjIsp+b?=
 =?us-ascii?Q?MAem/dF240NjDl9qqHHSDI5GDX2JIANixqKz6vTGHJDXcE0iCdcBH/bRmzSg?=
 =?us-ascii?Q?+xkf2h2rkhto3yhxbGEf5ZaIoT3xwvdVHEEEaOvSBS1NfdUL2XxjQezyPY9H?=
 =?us-ascii?Q?1+x/NbN8eCJJ/GrfW3kZYiLB27dMe/PPgIIxnQuzR4Lk8vX+44m17rWlcqC3?=
 =?us-ascii?Q?wjofktluKHbo0T7FJ8fF5mBW7beVfm1/4TYJc1aqJ7hztylphcill2MbbPuc?=
 =?us-ascii?Q?ivYixGY+jF12aMsSJ/tKCTyoDFjDjgq4pGYnN/O1tZkbJmM9TDCsQmWq5Ma+?=
 =?us-ascii?Q?61fwLv4l5N+iTgjMLoyZzvqFsXCbiiuRBSBDsQtwN/mBaFSUrVyEIidFLa28?=
 =?us-ascii?Q?7LdiaD3r5W4gyDEDHfJJ3kutACy+JHbL5cxceJAjQQRiFSDHpnUaUZ+ly0Lv?=
 =?us-ascii?Q?UXF6vw3ePcfYdIupWVmsifnetrqFQyF/SLzjIJGd12cyeoMDCFPPcguTHz8j?=
 =?us-ascii?Q?kIUec+k/7sCHTvrqvYf8c/5iWP2p0SJoB6L5GMDIo242Ih1dINizKT/FtZff?=
 =?us-ascii?Q?k6qdZmDc26uoirSaM3+TCEu1BoZTx54XrZ01+RmTkydHdbSZFsZOzT/ok6bu?=
 =?us-ascii?Q?TfMphQ/+ALm/N32KnwvPvac4FF9XwoL9d0FSrXx7f+lljLPxIODHdlbHc11q?=
 =?us-ascii?Q?QYoXVL+G1yYFLqVkizhHxgFldS0pHKADBj2CTtHrBpNMviNTJebYTV0sZiXj?=
 =?us-ascii?Q?geVwT6w+VJfDsecPxklW+KVRjfe+lcp84qXrCv7+uX9KTnUQbWkBwiUDJWKo?=
 =?us-ascii?Q?8j+mUZki1CtA6HYxiKWFJJpbwLNLLn8TkloKbd44+hTrG/8VsIoYam8Y3HoJ?=
 =?us-ascii?Q?Yg4xSp+Cqp37e91snbNM0zLqd8uTET26ISCVGvcQ+dOVN1NrJ9gCVjFylESm?=
 =?us-ascii?Q?iassJE1TswyR4zFuKq5r60FCw7bMCPJnU+HKpfoFTB2kaQ8XImB3xYMqZqMB?=
 =?us-ascii?Q?XzItqL3cP0JBczdd1omkYdwQnxlb3EWOdJ55YjiGSlico1YnjG5j1i/iSte7?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 023f7146-540b-4654-44b1-08dd6d529845
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:12:46.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYoToVU7OEPCIeWQ9H66CLRQ8haSec8uCJauN+JSpYN/kIvS2BGMI1BymmdD3J8n5Bk2rvQPqdS/nCe3Um6Qu22OuwIvMR/QI5Rw2PS2xMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count (provided the request falls within the limits specified in
> DDR5 mode registers), switch between codeword mode and row count mode, and
> reset the ECS counter.
> 
> Register with EDAC device driver, which retrieves the ECS attribute
> descriptors from the EDAC ECS and exposes the ECS control attributes to
> userspace via sysfs. For example, the ECS control for the memory media FRU0
> in CXL mem0 device is located at /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

With PMEM we were careful to route repair requests through the driver
via a write mechanism so the filesystem, or other components that might
have logged metdata about the error, could adjust its record.

I assume that is not a concern in this case because corrected errors
would not trigger poison on read affects, i.e. the repair here is not
bringing poison back into service, it is merely refreshing the cell?

Is there documentation about when an operator would want to do this
explicitly and why patrol scrub is not suitable to rely up for
automatically doing this work?

> ---
>  drivers/cxl/Kconfig     |   1 +
>  drivers/cxl/core/edac.c | 353 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 353 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index b5ede1308425..1c67bf844993 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -120,6 +120,7 @@ config CXL_EDAC_MEM_FEATURES
>  	depends on CXL_FEATURES
>  	depends on EDAC >= CXL_BUS
>  	depends on EDAC_SCRUB
> +	depends on EDAC_ECS

It is not clear to me that someone who wants patrol scrub control also
wants ECS. Can you make the features individually selectable?

I.e. something like

config CXL_EDAC_ECS
	bool "Enable CXL Error Check Scrub (Repair)
	depends on CXL_EDAC_MEM_FEATURES
	...description...

config CXL_EDAC_SCRUB
	bool "Enable CXL Patrol Scrub Control (Patrol Read)
	depends on CXL_EDAC_MEM_FEATURES
	...description...


>  	help
>  	  The CXL EDAC memory feature control is optional and allows host
>  	  to control the EDAC memory features configurations of CXL memory
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 5ec3535785e1..1110685ed41a 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -19,7 +19,7 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> -#define CXL_NR_EDAC_DEV_FEATURES 1
> +#define CXL_NR_EDAC_DEV_FEATURES 2
>  
>  static struct rw_semaphore *cxl_acquire(struct rw_semaphore *rwsem)
>  {
> @@ -428,6 +428,350 @@ static int cxl_region_scrub_init(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +/*
> + * CXL DDR5 ECS control definitions.
> + */
> +struct cxl_ecs_context {
> +	u16 num_media_frus;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 effects;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +enum {
> +	CXL_ECS_PARAM_LOG_ENTRY_TYPE,
> +	CXL_ECS_PARAM_THRESHOLD,
> +	CXL_ECS_PARAM_MODE,
> +	CXL_ECS_PARAM_RESET_COUNTER,
> +};
> +
> +#define CXL_ECS_LOG_ENTRY_TYPE_MASK GENMASK(1, 0)
> +#define CXL_ECS_REALTIME_REPORT_CAP_MASK BIT(0)
> +#define CXL_ECS_THRESHOLD_COUNT_MASK GENMASK(2, 0)
> +#define CXL_ECS_COUNT_MODE_MASK BIT(3)
> +#define CXL_ECS_RESET_COUNTER_MASK BIT(4)
> +#define CXL_ECS_RESET_COUNTER 1
> +
> +enum {
> +	ECS_THRESHOLD_256 = 256,
> +	ECS_THRESHOLD_1024 = 1024,
> +	ECS_THRESHOLD_4096 = 4096,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_IDX_256 = 3,
> +	ECS_THRESHOLD_IDX_1024 = 4,
> +	ECS_THRESHOLD_IDX_4096 = 5,
> +};
> +
> +static const u16 ecs_supp_threshold[] = {
> +	[ECS_THRESHOLD_IDX_256] = 256,
> +	[ECS_THRESHOLD_IDX_1024] = 1024,
> +	[ECS_THRESHOLD_IDX_4096] = 4096,
> +};
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum cxl_ecs_count_mode {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +/**
> + * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure.
> + * @threshold: ECS threshold count per GB of memory cells.
> + * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
> + * @reset_counter: [IN] reset ECC counter to default value.
> + * @count_mode: codeword/row count mode
> + *		0 : ECS counts rows with errors
> + *		1 : ECS counts codeword with errors
> + */
> +struct cxl_ecs_params {
> +	u16 threshold;
> +	u8 log_entry_type;
> +	u8 reset_counter;
> +	enum cxl_ecs_count_mode count_mode;

Similar comment as last patch about having a superfluous intermediate
object rather than hw objects + helpers.

> +};
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-225 DDR5 ECS Control Feature
> + * Readable Attributes.
> + */
> +struct cxl_ecs_fru_rd_attrs {
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +} __packed;
> +
> +struct cxl_ecs_rd_attrs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_rd_attrs fru_attrs[];
> +} __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-226 DDR5 ECS Control Feature
> + * Writable Attributes.
> + */
> +struct cxl_ecs_fru_wr_attrs {
> +	__le16 ecs_config;
> +} __packed;
> +
> +struct cxl_ecs_wr_attrs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_wr_attrs fru_attrs[];
> +} __packed;
> +
> +/*
> + * CXL DDR5 ECS control functions.
> + */
> +static int cxl_mem_ecs_get_attrs(struct device *dev,
> +				 struct cxl_ecs_context *cxl_ecs_ctx,
> +				 int fru_id, struct cxl_ecs_params *params)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
> +	size_t rd_data_size;
> +	u8 threshold_index;
> +	size_t data_size;
> +	u16 ecs_config;
> +
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	params->log_entry_type = 0;
> +	params->threshold = 0;
> +	params->count_mode = 0;
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrs,
> +				    rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	fru_rd_attrs = rd_attrs->fru_attrs;
> +	params->log_entry_type =
> +		FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, rd_attrs->ecs_log_cap);
> +	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
> +	threshold_index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->count_mode = FIELD_GET(CXL_ECS_COUNT_MODE_MASK, ecs_config);
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_set_attrs(struct device *dev,
> +				 struct cxl_ecs_context *cxl_ecs_ctx,
> +				 int fru_id, struct cxl_ecs_params *params,
> +				 u8 param_type)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
> +	struct cxl_ecs_fru_wr_attrs *fru_wr_attrs;
> +	size_t rd_data_size, wr_data_size;
> +	u16 num_media_frus, count;
> +	size_t data_size;
> +	u16 ecs_config;
> +
> +	num_media_frus = cxl_ecs_ctx->num_media_frus;
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +	wr_data_size = cxl_ecs_ctx->set_feat_size;
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrs,
> +				    rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	struct cxl_ecs_wr_attrs *wr_attrs __free(kvfree) =
> +		kvzalloc(wr_data_size, GFP_KERNEL);
> +	if (!wr_attrs)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Fill writable attributes from the current attributes read
> +	 * for all the media FRUs.
> +	 */
> +	fru_rd_attrs = rd_attrs->fru_attrs;
> +	fru_wr_attrs = wr_attrs->fru_attrs;
> +	wr_attrs->ecs_log_cap = rd_attrs->ecs_log_cap;
> +	for (count = 0; count < num_media_frus; count++)
> +		fru_wr_attrs[count].ecs_config = fru_rd_attrs[count].ecs_config;
> +
> +	/* Fill attribute to be set for the media FRU */
> +	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
> +	switch (param_type) {
> +	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
> +			return -EINVAL;
> +
> +		wr_attrs->ecs_log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
> +						   params->log_entry_type);
> +		break;
> +	case CXL_ECS_PARAM_THRESHOLD:
> +		ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case ECS_THRESHOLD_256:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_256);
> +			break;
> +		case ECS_THRESHOLD_1024:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_1024);
> +			break;
> +		case ECS_THRESHOLD_4096:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_4096);
> +			break;
> +		default:
> +			dev_dbg(dev,
> +				"Invalid CXL ECS scrub threshold count(%d) to set\n",
> +				params->threshold);
> +			dev_dbg(dev,
> +				"Supported scrub threshold counts: %u, %u, %u\n",
> +				ECS_THRESHOLD_256, ECS_THRESHOLD_1024,
> +				ECS_THRESHOLD_4096);
> +			return -EINVAL;
> +		}
> +		break;
> +	case CXL_ECS_PARAM_MODE:
> +		if (params->count_mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->count_mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_dbg(dev, "Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->count_mode);
> +			dev_dbg(dev,
> +				"Supported ECS Modes: 0: ECS counts rows with errors,"
> +				" 1: ECS counts codewords with errors\n");
> +			return -EINVAL;
> +		}
> +		ecs_config &= ~CXL_ECS_COUNT_MODE_MASK;
> +		ecs_config |=
> +			FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, params->count_mode);
> +		break;
> +	case CXL_ECS_PARAM_RESET_COUNTER:
> +		if (params->reset_counter != CXL_ECS_RESET_COUNTER)
> +			return -EINVAL;
> +
> +		ecs_config &= ~CXL_ECS_RESET_COUNTER_MASK;
> +		ecs_config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK,
> +					 params->reset_counter);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	fru_wr_attrs[fru_id].ecs_config = cpu_to_le16(ecs_config);
> +
> +	return cxl_set_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +			       cxl_ecs_ctx->set_version, wr_attrs, wr_data_size,
> +			       CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET, 0,
> +			       NULL);
> +}
> +
> +#define CXL_ECS_GET_ATTR(attrib)					    \
> +	static int cxl_ecs_get_##attrib(struct device *dev, void *drv_data, \
> +					int fru_id, u32 *val)		    \
> +	{								    \
> +		struct cxl_ecs_context *ctx = drv_data;			    \
> +		struct cxl_ecs_params params;				    \
> +		int ret;						    \
> +									    \
> +		ret = cxl_mem_ecs_get_attrs(dev, ctx, fru_id, &params);	    \
> +		if (ret)						    \
> +			return ret;					    \
> +									    \
> +		*val = params.attrib;					    \
> +									    \
> +		return 0;						    \
> +	}
> +
> +CXL_ECS_GET_ATTR(log_entry_type)
> +CXL_ECS_GET_ATTR(count_mode)
> +CXL_ECS_GET_ATTR(threshold)
> +
> +#define CXL_ECS_SET_ATTR(attrib, param_type)				    \
> +	static int cxl_ecs_set_##attrib(struct device *dev, void *drv_data, \
> +					int fru_id, u32 val)		    \
> +	{								    \
> +		struct cxl_ecs_context *ctx = drv_data;			    \
> +		struct cxl_ecs_params params = {			    \
> +			.attrib = val,					    \
> +		};							    \
> +									    \

I failed to comment on this on the previous patch, but for all of these
paths that affect I/O to media lets add a:

     if (!capable(CAP_SYS_RAWIO))
             return -EPERM;

...just to constrain the ability of drop-privelege-root to affect
hardware memory media state.

