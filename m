Return-Path: <linux-edac+bounces-1029-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DA8C19A9
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 00:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A041F237D0
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 22:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AF312D755;
	Thu,  9 May 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSGQPYU2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2912D745;
	Thu,  9 May 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295583; cv=fail; b=LyDmm2Ts7PJF6UVZFG1pp5A3xyEnFEw5WRsDImdSD1t21mmmk6EjWyI7eD9dGGSH+TZimW+SLYcc0kGzzfSXgc0K8MlCZS5QC0cZgmwAieRRRKNKagVvx+k1FC4lOi6gc/dCpVu2LZyjF88xQjSHvTQbPauHp2hqUhvPMjyIPOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295583; c=relaxed/simple;
	bh=NqxR1b29ZViKm0Q1uYcnqQlTJQcth9IaeRkKoMLvhdk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+6/45ajZl1oISmkJKHstoTPdzM/QrqmntKailnoIYj9pP0exLvWCszD7sMX0frxcS+jgQJD3jDpxLsTJX526d4mZI2h3K1YD6Pnl1mwAtlMqDgMjaTlZ7Fn0bK5az7DY6R3INLRZQYZvEU5KTLohpw1XCUsrkL6ebnyN4Q0l6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSGQPYU2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715295583; x=1746831583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NqxR1b29ZViKm0Q1uYcnqQlTJQcth9IaeRkKoMLvhdk=;
  b=BSGQPYU27kq9HfVKxnvY4Kq1Wqx7kwjGaqklO/Zl++sgCohoinCpberx
   unP0QO+595E4tALkDeOocZSTI2aq6BZGrZ+wNVdB+3aC70SgeaNXs+OiE
   OZslHOMvLFN363A6QIovpsxWOoT88kpT1qwAwfCk5U0jXj1HKA/QFnOSq
   X7uGKKM/NshQ/qrWC3uBgm7NqXfQ3b40xe2dirCA8DtrRrMQwLPjWJDPV
   fgPw9nG7CLzPBLCQ/bfVrIJZ4w1T8SNq1eCHQ9WRtneJ3pRirHcl7eaiM
   p+RXONKg5QlBZMw+6deOP4BBmA/DFqvO/4SwPA8EhDV4dYcU2dwKi/aWB
   Q==;
X-CSE-ConnectionGUID: dLW2uypbR9+XBGt7dEQHRg==
X-CSE-MsgGUID: +IsBSBSoRsm76yuiE29gHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11381219"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11381219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 15:59:41 -0700
X-CSE-ConnectionGUID: kh2ofR0fQ5Ov/aKbfyiETQ==
X-CSE-MsgGUID: R2pQL6kJR0m4EO0OiMicdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33850843"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 15:59:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 15:59:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 15:59:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 15:59:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 15:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvQg+dzCkiRUbSuDUPAKG6vjO+sIcZkPfQNgUsXjrajUyCwutfRhvP+HdlQXa+zNalhU9tvehx5rB+dSN3WdOi/dJQLVC7cRKSE+wuqaKIBtJu/wh4hGXGiFcQMrcGyaexG/nltjytLRg1uc2l8CmzhfA6MkHeiEtOtXavgxucVq71iGkosyOrO1joSU0LOr/IF1Gg7oQYvlobsQKceHBDmwETn2QWARvliLRSbFZFhZlrygdC9Cw5iXnGBD1Ix8+dsYQXtlPgV0tPTMc427hDS77+wbIw5TimVbH66t4KKmg8iwdnBtT6OmewzNVDJIYCIbUptmRIQsUoq+Ig0ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zXqOy5MLfCMwFDLOKDemNcNAGtvhZHZRKNwtnwGoXA=;
 b=i4isnbbtpfYgfeHaSQNqCiL7wGgOKQjnegE0vcBFWNHxs4p6LSToIZWQ+ftpDEDPsZwvX8USK3FHLkiu+lDrzzqQ6nBpAI8mRZ8RUxEbSfbiSxVofPrjI2RX7z8TvaiJ4PN6Yah57XddDRFsMDaz7lea/yWQQBTZwHkiq0eOnT+l6zQSmWO0x66ENgab2+Kr/7ytMyypG3z9Cz68SuR572n93PZIZ0NjBpshyezigIwafNvgl8Cug90WIXgn3SbWpsmOEr5+kL25iYDtF9/DQNBL3MG0IM7XN8PhrZT9R+VVYeFqXMmqP44UTnPxHpc5J57ZmQIzivwK0gMpbXD+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 22:59:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 22:59:34 +0000
Date: Thu, 9 May 2024 15:59:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <663d55515a2d9_db82d2941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
 <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce08aa7-dafb-44b9-5553-08dc707bb177
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AK46G8ohDzYvaPY/fHgHdzS8rkpG4sgcf1k1KbHL2HSiIW70GX0mompc9tTF?=
 =?us-ascii?Q?ldK4wrfNOXJ9dE1/G8o4zYjVcjTcdl/7uaWsjmP6VM4u7qG5yaS14TMwgN5j?=
 =?us-ascii?Q?X3SUdWWZiubJKZ3oDOH+3qYbGWqq67a/O+FJltW0DknA4WlNa0/SwCqZm3wU?=
 =?us-ascii?Q?ZTfDKjhU1la9kRBQznz0FhULAo8k1ddhGwqHxtmtSm+2/UerKhjW3JeAybrP?=
 =?us-ascii?Q?QuNEhNAOMpYjODc+yRMrCd4sNODXoAC+Xa9cjLmVHzby9ZgGJBtnw7F52Xwl?=
 =?us-ascii?Q?ucZAUfvXl7KlR07BRTRakevEo3lx8gJVWo/zP7QMIW2RhPZ6VhGIuaf7M6Pi?=
 =?us-ascii?Q?1E8QJ4qU8uS26QWWAiewYavIQTCS6Yg9bWQjgFk3iwy5b2txFiDY509kcQfG?=
 =?us-ascii?Q?GlZPPkJl0mLgPevC20uauyDAh+C8pwxRjXCstXvsk1pZg4JTz8kgC85SDLNO?=
 =?us-ascii?Q?2kl2176+qdN8Xoxr2xvkZuKZ1ectqM7wiRpn+5fMSmO0gNev1p9c3MWJQu4/?=
 =?us-ascii?Q?kX7TWi1S7WTzj4rArSR0Jsp9OXO+DSq/NgjD1WgeDjCFm36XmMSFwkikfNG/?=
 =?us-ascii?Q?6a+3lbrmJKEDtcyDClaFPA7ZHG+gz1OaZ8dRcH0TBVZ5Cp4a4SdZIPm9hCFs?=
 =?us-ascii?Q?mmimPxNnaMuTBqf/ghWX45ON+vHxQ275iBELeN60hzsYpF734Im45BjyyR8x?=
 =?us-ascii?Q?HvObHOfZ6nZb8OS+ufKC30zpOrEO3Wm6/71HSu4P+Jke2HJHxapbrLyc9/Ie?=
 =?us-ascii?Q?li25oGMjeJsxIkGrUSys79Vk5e7xhKNAiLU8gP9egYo8JuX8Q7L9YizblEcQ?=
 =?us-ascii?Q?+0v5jrmKj3ZVjyOdfUkmu6qyHbxI7h7Ivq4ho4zcywFGOK+W+Gvd5E5L8Cbx?=
 =?us-ascii?Q?gQwYwLV2K6NV1CJ2jJiSwfMdBlQVVn6u60myp33tZhXDvAiyfn31QFzAe3RU?=
 =?us-ascii?Q?n0N802qm12Y1MdX5wnhcMJhrmOkUrp5uvz3l8GB9ZEeU+YpiQXo4f/tqvehc?=
 =?us-ascii?Q?sgDXKL8pIg0Vpg7vr3XTTju1avZnthkNKczi5wHlcy2jYWI6Qd19udtWGQLq?=
 =?us-ascii?Q?nPZr2Pq3vKDLmhmqlmkP95Bma5n0jh8LwPFkin7oe1+kKLVpkQoMxX1QLvfK?=
 =?us-ascii?Q?Ni5CVaUhvGl9StSmEnsqM2Y4GZ3xda8t9r9Wux3z50Ug9muEl9tM1il9IL2U?=
 =?us-ascii?Q?WNpy/zcJg3o9dukSkF9A+vUdBdbMEp5QWrMoJW85sDzIeXfg1mTnamuwWk8g?=
 =?us-ascii?Q?dHKYLSCvXBAl/OlLveIt9POye/yrgHLTeNqnfIOsyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g26Rns69FQZcXR/A9Fikt/l9sB/89y1jZwjepOR6TrLBdDm02e+WvIvpm4gn?=
 =?us-ascii?Q?I+VJxpTQX7CDVAquKCV4nPlmpixO7HD8XyRYlBuHF7EnmD6zusBfY+SqnQXt?=
 =?us-ascii?Q?77ydEVY48qRaE9ZmoPPH43SeX2+SrOMaSWvclqkYJAS0IJAam3qvP4fJt5Mn?=
 =?us-ascii?Q?q7D+BUK7FfUWyCD3qY+W0jUZrExDf12CmwHmZvCo8PjMcSOviTo/rbDj5+3H?=
 =?us-ascii?Q?/1o+g1DJmafnZkQtb0lXW4OY7yqXC3aXQcT31/z4FOZ7SrTfhzTR4EznOWCt?=
 =?us-ascii?Q?nY37d65oGLtjnQZhlaQZnvaFaoA60JKwiWLHhsD165Lf25JttYC3LpOpAdfc?=
 =?us-ascii?Q?/gLCTNvHEy1eZqhT35N9pCaVNDBJm7DwqTnqy9IdtPxrNMp4QKY03k10GJCP?=
 =?us-ascii?Q?3Zq5wgX/srbOMXVdxQUL0gWtz6njNab2yQLzMhsQ6stpeKVSy9nDXBo3zL1E?=
 =?us-ascii?Q?RAnDKgKfeU79Eaa0ZgzNp1ElM2iS/g8zn9Tpxx4ETNMYa56eLf0Bc+AbB9P3?=
 =?us-ascii?Q?3Jxzak4izZpjy7erN2xbnLx85xTSM03Ygzeis2rWDutT0LEJK5aPmlWIq+Su?=
 =?us-ascii?Q?zbmkbxXsNDAEmIdKedbGuJskbjB5ulHcPnCIazOXzfvUTD8NFpn0BTVlYhqW?=
 =?us-ascii?Q?rQP89h+5rBWJuk6LHc8QJR/x/A/y+v4MsLYuguPbDZDfwSTmX7Sug9WZlvah?=
 =?us-ascii?Q?TIORdmq/K8MUdmtmVwUoDX89pPRW6kWXwjmVMqWUMSo3A2T53B5ndjyX6t/8?=
 =?us-ascii?Q?f/S+ShuYy5tu86n4QbhYS9Amg48SiOKGLhIBdhBeWI1PcayNH8TmSwMavULQ?=
 =?us-ascii?Q?j6OtENC8TgliUcMuV4MqiCArCEyE6IuM2MimaHaYj2rtlFcX152/BrIpbmHD?=
 =?us-ascii?Q?OoCRr7mB3LxuuKJna7hasFq4oRgHnmRR8Rlmmcc7FnkavAk2kjbmYyO8zN0H?=
 =?us-ascii?Q?0+X6eUKQ2aXBP7Zm56s+PiyDFp29ISyFgfmm22i+QT01w/DzVRDGqNqz75Ij?=
 =?us-ascii?Q?iATdkh8Ng4Ph/B6UDAA39ewqNt8cEjx7Vry8ybbEOGmr92EXZInk4Xz5bumE?=
 =?us-ascii?Q?Jk5uYE0PmUFoH5Q4DVUEJhgW12sJ3jCLgXqHnf5ExUfiqunqpVVOJAQ3osmZ?=
 =?us-ascii?Q?Pb6VO2ak4v2HfE4pPIPQ5OxhFgc0/186XMhq6X21Nj1ZABVM02+upxwgAOAM?=
 =?us-ascii?Q?AXdK7xSlrMhdShahYgdX+egefmaC77nxUkAgqxxmlZjdAkjaxvoioQK1NGdE?=
 =?us-ascii?Q?hvqymky0a7U/ihuUu2QseixBDFQLbLIIl/V3RxXatxUUXpXGRUakIbN1vd8B?=
 =?us-ascii?Q?h93NkKMBDp6rqv3X5PSo4vYY+FOz3n0vwbhH1539qBDuTEb1XBPPIfnVEVIV?=
 =?us-ascii?Q?vmOdOxvFMe+a6u6h6cylnEPDxo/Sc1BIi/XGxfu5YrZGHkTRq5YAj80PfJ1F?=
 =?us-ascii?Q?aNUIla+M8WneJ0QB9bwo1WdrIE6kBDk1z95ZKi5l5RmtDJNhwvgTM0LJYMf1?=
 =?us-ascii?Q?LZDKIPEsvjv8Omvf2K+MhNDP9PIYuoYKv/zbVFklBEqIszSTWY9GF8AcGhnZ?=
 =?us-ascii?Q?BMdbUqvXMgJ+eOfXxujVr0TnKhleAeNZeHIJWB6GhTNeOl+fCXsLMUrV0mUq?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce08aa7-dafb-44b9-5553-08dc707bb177
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 22:59:34.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOtP7aKMQ+aq13o+H47sYpOILKEBg2mOpcWayEg7HIupYHln/+H6UvbC2Sv2o/edlekCBOiJJFWTO6b5V857w888gmqi6Iu0/z9rPiNHD3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> On Thu, May 09, 2024 at 02:21:28PM -0700, Dan Williams wrote:
> > Recall that there are 461 usages of module_pci_driver() in the kernel.
> > Every one of those arranges for just registering a PCI driver when the
> > module is loaded regardless of whether any devices that driver cares
> > about are present.
> 
> Sorry, I read your text a bunch of times but I still have no clue what
> you're trying to tell me.

Because taking this proposal to its logical end of "if a simple check is
possible, why not do it in module_init()" has wide implications like the
module_pci_driver() example.

> All *I* am saying is since this is a new subsystem and the methods for
> detecting the scrub functionality are two - either an ACPI table or
> a GET_SUPPORTED_FEATURES command, then the init function of the
> subsystem:

No, at a minimum that's a layering violation. This is a generic library
facility that should not care if it is being called for a CXL device or
an ACPI device. It also causes functional issues, see below:

> +static int __init memory_scrub_control_init(void)
> +{
> +       return class_register(&scrub_class);
> +}
> +subsys_initcall(memory_scrub_control_init);
> 
> can check for those two things before initializing.
> 
> If there is no scrubbing functionality, then it can return an error and
> not load.
> 
> The same as when we don't load x86 drivers on the wrong vendor and so
> on.

I think it works for x86 drivers because the functionality in those
modules is wholly contained within that one module. This scrub module is
a service library for other modules.

> If the check is easy, why not do it?

It is functionally the wrong place to do the check. When module_init()
fails it causes not only the current module to be unloaded but any
dependent modules will also fail to load.

Let's take an example of the CXL driver wanting to register with this
scrub interface to support the capability that *might* be available on
some CXL devices. The cxl_pci.ko module, that houses cxl_pci_driver,
grows a call to scrub_device_register(). That scrub_device_register()
call is statically present in cxl_pci.ko so that when cxl_pci.ko loads
symbol resolution requires scrub.ko to load.

Neither of those modules (cxl_pci.ko or scrub.ko) load automatically.
Either udev loads cxl_pci.ko because it sees a device that matches
cxl_mem_pci_tbl, or the user manually insmods those modules because they
think they know better. No memory wasted unless the user explicitly asks
for memory to be wasted.

If no CXL devices in the system have scrub capabilities, great, then
scrub_device_register() will never be called.

Now, if memory_scrub_control_init() did its own awkward and redundant
CXL scan, and fails with "no CXL scrub capable devices found" it would
not only block scrub.ko from loading, but also cxl_pci.ko since
cxl_pci.ko needs to resolve that symbol to load.

All of that said, you are right that there is still a scenario where
memory is wasted. I.e. the case where a subsystem like CXL or ACPI wants
the runtime *option* of calling scrub_device_register(), but never does.
That will inflict the cost of registering a vestigial scrub_class. That
can be mitigated with another layer of module indirection where
cxl_pci_driver registers a cxl_scrub_device and then a cxl_scrub_driver
in its own module calls scrub_device_register() with the scrub core.

I would entertain that extra indirection long before I would entertain
memory_scrub_control_init() growing scrub device enumeration that
belongs to the *caller* of scrub_device_register().

> Make more sense?

It is a reasonable question, but all module libraries incur init costs
just by being linked by another module. You can walk /sys/class to see
how many other subsystems are registering class devices but never using
them.

I would not say "no" to a generic facility that patches out module
dependencies until the first call, just not sure the return on
investment would be worth it.

Lastly I think drivers based on ACPI tables are awkward. They really
need to have an ACPI device to attach so that typical automatic Linux
module loading machinery can be used. The fact this function is a
subsys_initcall() is a red-flag since nothing should be depending on the
load order of a little driver to control scrub parameters.

