Return-Path: <linux-edac+bounces-1030-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB88C1BB9
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 02:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF672847F1
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B0173;
	Fri, 10 May 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWc2IVJX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F92114;
	Fri, 10 May 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300817; cv=fail; b=H/7VGBn9MsHr8Vzb8YiZiHRWTunvT7GRVTe/vok94RLZCjrNFdQPcatDQZ6iMykUl5TAgQGtAL0MKm9jyjp423dNGDsWhXuHQNTauIf1D7J9GgYxL2U9Zwoh5qTFUXDgfgViaq0DT6uYykAlAxsAfH02lhiSDp7RMVtmAaya2u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300817; c=relaxed/simple;
	bh=SBpfGmYdTbxjHNtuo8r5PdR/2k61C6nv5ku9VT4mKWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYLGtYmiVB+Px4RFXqd+pGt+3gdM8Ru2Qi10Ot4qwcUUA9uqV9X9yoNuXavlY0FmJMMsm8vPsRSi1tHOQR6bATcBMFsYrlNvz9xRn9dZRYYCRegnwLehIwHY8bn7lA7q7mtHJh4sLCbk7R7e7v6LPzjHaXLZJqZ5Y8pGxZVa054=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWc2IVJX; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715300815; x=1746836815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SBpfGmYdTbxjHNtuo8r5PdR/2k61C6nv5ku9VT4mKWU=;
  b=eWc2IVJXGG43AJsAo52XiecikoGLfERwD43czM4xPZwrL6tcSDDNhsqE
   OrvohDTR4HhhekSHRk3v3C4OUJgU0+CQ1YGHmj/Bsg5keRy/y0P7STHTK
   C3bJhOxYP9ROsCJht9BXzxt55aZ/4MSRs31MsFFgmCvQvYiZRHWDatax5
   cqLeY+bnDkTQjbWOwIlFgCwfXECZ6Jk0wbGZfmB7FUwfIU6tP50+1mYoS
   80to3Sv0ve6FVg/vAj2L5eWlm6yy4KJ5fAKUq8QNLcrhJD8P+KevhgUXn
   1F6m4zm0uVd2nSx6B2JmSVANID0xZKvVQbJGgLcT6ZvO+rF1rfR1+BST7
   g==;
X-CSE-ConnectionGUID: yaTZyNHWT7Oi9KsdVKlDnw==
X-CSE-MsgGUID: rNdPHlEqR2mL1YciLkXbBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15069425"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="15069425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 17:26:55 -0700
X-CSE-ConnectionGUID: oztWaVxLQZy9VEN1KMfaTA==
X-CSE-MsgGUID: TntN8Am8QZ2h/bWN77OVQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="33959592"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 17:26:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 17:26:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 17:26:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 17:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JClNTVD4HwjZZq5I3v7ztBr/uhS6A+LOC9yZ2Ayo/2b3PjGutOBf+CpZr5Nk9K3ExE5rm2g0ISxggL0NcexuyYfCbwC9HWt4vJQniEPowvpmXxnt8BUcRZX3n6FdWob4nGMCehQ7ngc4Go9MdqLsKFPJ5WLrN20G2wsVtgX9gca7d4Mk85GjLvvpWNErJHKuPQ6/kvFjS7wqHJmCxxDpM8PTJE9bPHH4OB8h9G5hP/xhDIW++tkRY5L9VRrnzV8VBy62lyK3Y/l6i6Wvm02PRuRclolWN6djXquIsxe8XbN0TP0RRjtyzdsKtPCE5IboL3q5bYihijaNfnqyHW+Uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR0SbteOuviL+rDy/OnQkLYMhH1g/HiH98P3yhhDA0Y=;
 b=Fm3zy3EWZWMF6/uCNL1gc4NpL5s+G2JHA+b20lD9uGSR+Cikjor+UiUMwtYBOYT8peM3TR6FbuB7TmBadhmslvhOk9/W27+EBEu3MouCvFztNpw2PJNt+NTceFtnKFR4zGnAH6KGrp0IjMTuH9RRvnaYvSNTmru2kV9hyYHbma4TNw0u93HwdJmL2SGk1524iNAHr9B4X0SfQ9u6PlOe9eQ031M1w5tGvQh39v0ps4lOMMgfhcSo69qHXPdNBq3XdSR6jUL9V0j7PwXriY9GjM0x66OXvZqJBT0GD8N2dy8MVx+eep1OdH5gt1psdKUdgjJKsD4kiG3SH39hsC6u8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Fri, 10 May
 2024 00:26:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 00:26:50 +0000
Date: Thu, 9 May 2024 17:26:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v8 05/10] cxl/memscrub: Add CXL device patrol scrub
 control feature
Message-ID: <663d69c61db8c_3d7b4294e0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419164720.1765-6-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d06172-a345-4e3c-fcde-08dc7087e29b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/sCVpcqFeM+xzJhPJLZEyaJpoSyJKJyLz2aqsOrSMZ4fFJqQNcsNos1Lsw6?=
 =?us-ascii?Q?lx66Kh3YuwTyNgzoLtSGY+E5G602hMPhF9yvzpP/IbvAjH578de5kEyAIetd?=
 =?us-ascii?Q?elVlXs3D0PxksRNP+V4SxzZ7rxa+xp3iaDY8bMaeo6xGsBON9OWMhAjcUouH?=
 =?us-ascii?Q?6N7WkxZdu8NIz2qBpJhDCqtxZp0fIaO3K/MDgFZEVEfA0vPph/TdBaPw+QJD?=
 =?us-ascii?Q?WZIJe3scwaYCWRv1QTXMck46WnYBXAPBVs4YRuotUNgtwUos4IY+WL4qR+XY?=
 =?us-ascii?Q?vVSONTXZHh7nzZ26A6nPgFAcR7zm/TP5j0fdmZ2al6wYqhs3G0+qvnI6AOl0?=
 =?us-ascii?Q?W948lh0YtioTbSKvC4JcHtcj5N+Mj8mrVFDhHqsAoVd47Empzg18VhxhNABb?=
 =?us-ascii?Q?hz5V86XsEylW8OqowR55N/d3pC8KbeMCPjWV9OgN3hM8BLPEdURicD7PD9iS?=
 =?us-ascii?Q?JaflTUEwHc0pAXg488dnnuSYi+VAJPNA2BaHpS51Csq80khxKpQ6XwHmMMbz?=
 =?us-ascii?Q?M78v8+ZP3ttpwPzNWXSuE46GQ5OBKbUqlwLG1SLrHG9fQnkR3LpxSNI77nQ2?=
 =?us-ascii?Q?5yCoOwyQCRbiYA1EPr44Pv+95OWWQ51pb6uCftzfZ3Wa1oFZxLXiTPMr24nQ?=
 =?us-ascii?Q?gOT/ye3WvMOwj6ppi2RvOTiHive3NBMv8ild4ItPLXxFE+JapG+IOEWzztfN?=
 =?us-ascii?Q?rkFLAhAR6Qq4L+SPvUZkgTVJMhEiQzdmkOBNADwBd/P7b6ZoThyUwMnjunol?=
 =?us-ascii?Q?IAwX7vKl3A0vwL7l4Psiw2iPZUx235zDKYIo5ZOdtLDPeBl4bs4iusEWPUKt?=
 =?us-ascii?Q?6+cBKTN3VFfZfAImK2UOxbRIn587z6+TLTM0nDxxZKaUNbVn13QZY0SNqD8t?=
 =?us-ascii?Q?+eiet0hGaeqJX8H9SRMAHrTVqN87NHG1dxrvIecDOtDMqnzN78KJ+ckK/LrR?=
 =?us-ascii?Q?072kNlxRsLiNk6A2MXMx/V/NfB2S8c6sGLiC2vX5l8oSbujVCtrkNNoFVStF?=
 =?us-ascii?Q?nlY/kCYqXVeenZ4MdRd0feVvN0Fa8ph5V+tGPxG0O6FyVO15536z9l5IQ7F+?=
 =?us-ascii?Q?3AGyp3L8WN7pYwFz3sgXc+SV9GGBpx1CkcRimQIkmjIenTeeQVTqSqGml2yG?=
 =?us-ascii?Q?axgMk1kZr/U7+iN7B0beH4CdaVyTysWpDmZBS4FF1BvYHI4zPns/4MeRJM9S?=
 =?us-ascii?Q?u3nRRuSda/GE2wzT4J8p2rJAg2aoMAlJvZDGVnTRgWTHNowit7qJiHnPDapl?=
 =?us-ascii?Q?itWuE0J5haSKwXjT+Skby6mFpYBS3W2W0qPCmcyV/UI6E5ei1MH2j8GuaHjR?=
 =?us-ascii?Q?6KkQ9zrdw3uYhpVd1yOHfjw5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nRKtxp9cIUh9ttLQus6XAqc9HEgyHBRx83D6Bb7yc7vTJBXJ8qbxXKs7Fw17?=
 =?us-ascii?Q?Y1CYtGYyyeTTt4Vx4Y0sSqSJUxrGwaJsleGwHGFpPrI6svvVxmhmNTta6rL4?=
 =?us-ascii?Q?cvOonhZR2Vf57zEIizMI7biEmcEhvA/UgTPhB1rhvAbw8xH9ARjxqKdBZVCU?=
 =?us-ascii?Q?fJTiQTOqN9SxMof6/9CIyvOS0GzECUk2ESOZkHr22AIT3GvKArmP3HknFMAd?=
 =?us-ascii?Q?8BJnUrTFnwqfq0CVRjGZhmu91ZWlngNnBjbovKKtLvb5B1/86vqPK/qKHy2I?=
 =?us-ascii?Q?+3vlxxOg4FD4S5JLqXTfkoKsLBfdo2ihmQKTspCCktwFByBYhvQQnEL8jhiM?=
 =?us-ascii?Q?HYmrAD2nPWB7bT0Ft3nXDe52muEhdkheJEeR0GPL9fkdXpszyTPW8MzaIqbc?=
 =?us-ascii?Q?J9Z73hnwMe9miMuD9XMdNqNBf/6CfGFaCKkwZYcqTHqY7Jo2JphifxlUviyl?=
 =?us-ascii?Q?eXj6LYTsppdL2pWghfZ2ZWwN5gCvOmtf/s7onqY39/U3RippWuD4/p4+m+bl?=
 =?us-ascii?Q?r92D0+YMjt9XshGvEO0ba+7gxaT2kjhHS25bM29G7M42chzTYvczttzaVK+4?=
 =?us-ascii?Q?forL9Wsk1+PnMf7t9jzBGZyc6W/AtI55GelfVn4fr1EDwacvGHV62utZeTBF?=
 =?us-ascii?Q?yh61XDVmk6ZWUn034lSjmUVf7OgYD0hz9yfQ70U+3fOZZ4VZzoMHqgdnSTWa?=
 =?us-ascii?Q?PoXMJ4oxf6tYglSnauXYGLizb/sGN1sNj2l4ybqZ4SCvCJL8SsI7lWU6yDXA?=
 =?us-ascii?Q?bzw/P4jkbwRhLesUFEPdC1qkk+/FJ0QotkUvv5RBCYmCREgd9bOaP0O1uhIS?=
 =?us-ascii?Q?6g4s8X1VdA3DJujkzwkxwD3UzhMiVHLqr++KQRzZBMp7pfrAlSgkU1jABdBt?=
 =?us-ascii?Q?qSk7y8Hh753VIVzlwRcF3Ho0uNT8i2Ne3UwjaA46FiRD4cecO+GcRgxqYIiU?=
 =?us-ascii?Q?KSir3YchTbCTGZhKdgRmgu9zphz25uig0QS1wsO8pytVXzXd7A0q7J9LbkPU?=
 =?us-ascii?Q?PQcC8/YQygeN476a6PYmbejgmBziSmuMws7i8/LbsBCI2BwktWxJYGWTNjSu?=
 =?us-ascii?Q?g0gDDuWMz8RhgYlfrE1xWdMKsjGVkUdIWgUVdxcqCMnY7JiBrjG5F9wU0Gyw?=
 =?us-ascii?Q?875qWxSXLrF5dJY8uwxFzuRPySyRldRBh2XVFxfpRINZJaGIRYQ8zRq/A/NL?=
 =?us-ascii?Q?R68n62G23Dwgrr52sB0RMBa0AThj7VOIVGAM35rS/AhL9xiJOPkHSpd13CG+?=
 =?us-ascii?Q?8kXetiVYvQJgOGw0uBPtsHOS1fnAAKa78oS/mDNIVQiieKSh/djarMaYDRjN?=
 =?us-ascii?Q?sDb/7FwZMtmcKJrrWFUcS8rZpjXJXFVutsCG+Eu9+AXyENr7rhbT5PjZaEmk?=
 =?us-ascii?Q?SCA6fcdL0mPLqM7gIASiPP84wMST6p0XX67yck7cp6pU7yi1PuPezQhvE4bl?=
 =?us-ascii?Q?xnZnFEasrxFIO+SEX4tsWwEtv4+8fAO13SybvJ3PrxWBBbBdz6CMkap+oczl?=
 =?us-ascii?Q?7lkQD+yIAf9P2ryP1rwqiGsp3BLDQ4q53z16GfzkIz/XdKNtdu9zh9KGujtY?=
 =?us-ascii?Q?aHUotKAvYcNFRfFsL6wf+hPhhi4IXxxVRWHV3QEvQL1tBnwliV3MwnElW7BZ?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d06172-a345-4e3c-fcde-08dc7087e29b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 00:26:50.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbTBOJmrBm2lUuN6fCk3Cwh7Yjw23Mb4nrMKhVAQ5UG7zJWEygAA7hyXtlucly2O7/vPSXo56PGZv1wt0d6m/mkhT8gt55CJ2MWbeHknr2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8490
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle.
> 
> Allow specifying the number of hours within which the patrol scrub must be
> completed, subject to minimum and maximum limits reported by the device.
> Also allow disabling scrub allowing trade-off error rates against
> performance.
> 
> Register with scrub subsystem to provide scrub control attributes to the
> user.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
[..]
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 0c79d9ce877c..399e43463626 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -117,6 +117,12 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!cxlds->media_ready)
>  		return -EBUSY;
>  
> +	rc = cxl_mem_patrol_scrub_init(cxlmd);
> +	if (rc) {
> +		dev_dbg(&cxlmd->dev, "CXL patrol scrub init failed\n");
> +		return rc;
> +	}

2 concerns:

* Why should cxl_mem_probe() fail just because this optional
  scrub interface did not register?

* Why is this not located in cxl_region_probe()? If the ras2 scrub is an
  HPA-based scrub I think CXL should do the work to interface with the scrub
  interface at the same level. This also provides another in-kernel user
  for all the DPA-to-HPA translation infrastructure that the CXL driver
  contains. Pretty much the only reason the CXL driver needs to exist at
  all is address translation, so at a minimum it seems a waste to inflict
  more need to understand DPAs on userspace.

