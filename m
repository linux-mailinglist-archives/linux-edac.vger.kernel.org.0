Return-Path: <linux-edac+bounces-3402-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785EFA720D4
	for <lists+linux-edac@lfdr.de>; Wed, 26 Mar 2025 22:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329E13BCCAC
	for <lists+linux-edac@lfdr.de>; Wed, 26 Mar 2025 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE71FC7F4;
	Wed, 26 Mar 2025 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gng/Qy00"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14601A0BF1;
	Wed, 26 Mar 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024811; cv=fail; b=d3zjD9beOm+nc+RGLazfvgrLY9f315h7hrmGK2I4erRi+diRfQACbQnlAPvxV6V6rU9pMb68tu3rUMMrvVjoiQS+o7ImSDS4+9+Id0hoHl/NzggxMD0yIJIVCIrt4H4RAZdSOm6HzIaCOKpkfuXmTqhXq10aP4FpUplY1XKMfzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024811; c=relaxed/simple;
	bh=17laN2GmdY2mOucZeXOpT4faRMIhlbGY8zDXOjsXAyw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCrv6Z1pVDsQQOzt4uWIKJN4aQrh2784OLpVB+tiCn/T9U8BXeuwfqYznMxhgu50ArUdqWIZc4bbzU7BJOuHQISina9smvYhmfL4bpCAr6KsubmkYmzPuX2f6kRjFQIvkFMOUONBJET3+iV0vPd95isXPIhD5QcWBY5dq0N1Qig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gng/Qy00; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743024810; x=1774560810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=17laN2GmdY2mOucZeXOpT4faRMIhlbGY8zDXOjsXAyw=;
  b=gng/Qy00SS+R8CBFGcNrR8Y4LwGImI8VR9df/BGjOjFlWY5bc4kNyVYn
   AgxRyEfhW8qZAG/RJF9BUCQv8l7fMEjMcZvryE+GYpP58KWlyNt4URGgx
   M0PKtBK+k/3zKe5YUENxSKp7TBYrv7NrZsPk9BOjGPKcZdf+y4lR6N/Js
   gK2wxjpxhoNHwAizyA/P9s2lfkqjy50H8Ja6FWgl580X0118hkC2CuNrK
   16Jil4T51OkZJDP3W02bj9d3zEjqknr8OOXW4GCre+2IB0Kd3bHphERUm
   FXFD6XWE+KvEu6VWH2nk0lZrjE4Wge2VWi76FDZU+H7YXuvVY33wsbLLq
   w==;
X-CSE-ConnectionGUID: 4JSSXPEfSimAuOHtrXGAMQ==
X-CSE-MsgGUID: u0BHbbR6RcOClW4G3gWbnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66799725"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="66799725"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:33:20 -0700
X-CSE-ConnectionGUID: TX2QWZEbRHWcn1QswIV89g==
X-CSE-MsgGUID: 5JaCz4Q9Rg6uSxqnIXd5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="155914522"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:33:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Mar 2025 14:33:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 14:33:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 14:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TToxx5MB6wT/O/n+D38j8ID26lJFRJI4yMPpdUUSdXhdxKW0UFqfJTXOAXM4Yd/wM7V+nRxuxsYPNBkalV6efJV2ckW2W9zceSgTNOHS3++f+eYAGsH1yUHhgqbuo3mD7yDOxP1s/at7I9tMhtKqJL7GOFVvEbAWwvMLmOBG32mfbFkgksiTfd1b+NRBf4lEcbPVCM5ffDufCeJUicZEJDlESYbdY6P39ECwlRWDQtGvxkwFkVGSqG+vxBe2gjib2NFX2N/1MKW8oSwYed5vPVxgjnjztt0R+eMG1PCgxg55Xe7npELsAgukB3uQRzcO2/L9qzUM3pLWt73TD10Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXrYn0YOhR8C9iSpNTyZIrT0XZsxP74ERCUgLslfV+E=;
 b=XNIqn0b3k3LnazZpwEF1RvLcWOCMyKEPnNiJDCc/cMd02B1NSIElqqqJkYHUMwgcLNevhRGEOGz10PwUhUJnGKWh/gxk+ArV8DLEz7rPgOm4w7tEnVGE5EE/b1KvJ2ZGlDdIE1G3ezE47iNSBYgn73r2LGRPd63GVunJOY5PgnWCjq5LE8LD0qxPPxqoUCtH41Pta1KMO5XdNobsgGnjWipiFJT8Q3vRs6hfOPZCQmRpwjnYtKl83EZ2TiCrZJam68ZXoSJo/oB6Celjb9wbdCDlYGJRGjyJLE1hIwfdUvK79fY9quRI8TSrVQfroXZs3bZA++WA+gQe6RFufkFfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 21:32:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 21:32:59 +0000
Date: Wed, 26 Mar 2025 17:32:53 -0400
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
Subject: Re: [PATCH v2 1/8] cxl: Add helper function to retrieve a feature
 entry
Message-ID: <67e47285c1974_152c29442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320180450.539-2-shiju.jose@huawei.com>
X-ClientProxiedBy: MN0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:530::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: d198c3ec-b37f-4d9b-abe2-08dd6cadc7d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g9HadXJ6g4yubM2bWa0m2XlZEepAFKxcXvmU9pwo+c+6+Rg0CmelQAWXsnY8?=
 =?us-ascii?Q?evI9A6jyRktZTTnC5375lQ4rEwhc8T1y5x5NZ4imGkUmYQgSSNxocDzHeMaE?=
 =?us-ascii?Q?4PQzjMht2YbhSbyXb5hJ5HDMRIO/A6Xt+Lqm+Qb//kRuiCD9v/Zmvx1PcQnx?=
 =?us-ascii?Q?QHufs5zh6ounfqTJ5DgmGgWvdNZ+hxzohNCLQhTfb9hT6YrBBzp7vXP+QsCl?=
 =?us-ascii?Q?UuQRYpYXSMYEX0kDJUIXqWURxJJdOjLXiBzvGj7MP0howGr6HiW7Iy2Wq3yY?=
 =?us-ascii?Q?tYib1eUZ+Z9LaeV52PRJai/x5cUF8+7lf3E4oU0pNy1jPbUp18Y8bLSJytJu?=
 =?us-ascii?Q?Sq19HO8pwDInG3XONL51bZ8mku3PARdhZOe3pxPXbp7pV9Ex7C+9aAhqY4B9?=
 =?us-ascii?Q?9aMsneRLVzhxQ27jaVNQnJ0kb8m3yVq8Vugk6gJP2mRVwD0vOJARlSpr2hmY?=
 =?us-ascii?Q?ymw8gY3jVYASW8gLBk+wbQy9x34hTWekEKr5J5BDbKkrz5awRPLbS0PqI7xF?=
 =?us-ascii?Q?x1jUf5F0je6JrFUfFjALjE3nX+s16HM9JnuEP5aB183H5T9F9gDABK7Ot9Cq?=
 =?us-ascii?Q?1jYIZJ11KsJOYmNHUhAYM6hfgYQlQHbvEF0x9Sb1AAxTMfOq9EpypaO53ZxY?=
 =?us-ascii?Q?g1DzS4uJ5z1JM/v9EV3uMQXxsPYwrFhmhe6nU4INRWoDgu+2daXYevGuU3+c?=
 =?us-ascii?Q?wRjFk65tyoeoiWrVhpZsn+/Kd+rYgY+7kKh3cC6K/+POUcDdrjn3QnoKp3Xu?=
 =?us-ascii?Q?StuHyQRP7RP4dZlvfk1t1HXK6KPE+r1CH4KQ7uOL7rwhYx2glyn05JWUyzDd?=
 =?us-ascii?Q?8IqJmApT+CL4FyDY21HG6G7iiLJD/i4PYn3b3xdii1JxGshB68pnyROGNm/s?=
 =?us-ascii?Q?iCy1TQnnCyA5PC/y1yyAbGahf/fEgrkDkB4QRA8381vZHt61ZhovvnyEsGiy?=
 =?us-ascii?Q?uqQ2L6VhtaWGPJhBGp5B6GujcV+u/wc+s0ydCBVo/X2l06BI/b0kkpEMcCd9?=
 =?us-ascii?Q?EzThsQtDfjaCxffrFp6F940+/QQAn5XkneV1xRC2v6xq0i6pgIOVUgmzBdMr?=
 =?us-ascii?Q?+0VzjlLa/NJO6qRG26obi86cPzP+87Uz5HtScXxkH6JIjRV/O1GVkYGEIRiM?=
 =?us-ascii?Q?p3VmZFjfJHXWRjbz/qjzWqEaW9K38MINRPMfSdFWeyvk7VfXIOCTrpgCuoJb?=
 =?us-ascii?Q?VdzawR7vEhCFa4M3/vkye2n8Lm5f4X5+XIhzDSoEaPF1YAmu+nUg4TJWlvQn?=
 =?us-ascii?Q?WUzbYcpHWzMOtwnhSu1gcL5SoUTRr0PrY41kAgzLRexiBibxVH/DSRKtS73G?=
 =?us-ascii?Q?GKYQ0lxErlJVxOGLPXdDkS+ZdDXWXYtBAUxAztAVcob/Wv33m3L4zyx7yfEp?=
 =?us-ascii?Q?9nX/qRCKo+LbbRwkaYfBQIJ5VgGrRQbofo2h2vjc17ANFSuteIZtUfQ1ueUa?=
 =?us-ascii?Q?hi5d9hYmNAU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2R1A6qO12qWgrk8mLUAcZ8O8mAprBFQxAr1b8X0kbo8PCYyqd9B1OOoO9D8?=
 =?us-ascii?Q?QGsey5gPTAGsHMPcxNQZZ1S9csvW8mKveyXbN/zelVH4oPhZA26mjuyvQvzk?=
 =?us-ascii?Q?dFKrf7fnNDPlG6+rkUqtcftfGqQDMxh7ymEq4PDFkzJ5Vhy/oDAFCKqckd6u?=
 =?us-ascii?Q?/9SQOQ4TRK+VY1i5tUWvkpgNpKrUGH56G1QbGHMCDIKHn1bURjDqMZWXpnDh?=
 =?us-ascii?Q?I9hlwENBBwnaAZ39bRoepzCPQ4NyEnHhqw/TfdvfNqTNZYVnGNpKv+2wX4h/?=
 =?us-ascii?Q?9ANwr+BbYJxm/xfEI5KDy3ksZn5mHxFohnRBn2ydnIyqm9OhhQU9rpH2pACG?=
 =?us-ascii?Q?K3GoWmPROToQUVVIN6e6s2WQA/vr8gIQZeI+p5DNcQ8XnONeZOb9tZ37ign8?=
 =?us-ascii?Q?LH4jcuQV2E68MIRVSOm0veF8F8VTSavV4bul4HLCcexJYusAYSoh4mNpyMvZ?=
 =?us-ascii?Q?rHy8Oww7YREuAOZIPG58sdStGl7v/uFp/oZWzMICWtjIn3kIwFvWSOKrV9wm?=
 =?us-ascii?Q?CZWptnChMrxwUvxQY+kTlg7sAUEEJEhsc8ImdcirPZureK53L0EDU37ew1Ix?=
 =?us-ascii?Q?fgxndRudun/WrDFDEyRYzrViyI/+TdYifV+Rucqj/Q4ejnx6JQG01O2M6zLR?=
 =?us-ascii?Q?QJEOoB/iH9JNhMjPRXvsqKM0s3gZCuIgYRf8d4qWItqCsx6vPqkJkNlH7Nm0?=
 =?us-ascii?Q?5Y/oJaKJdpJZaa2rJtZWDFXBeWfby2KunDmcZ2SRUhRA/iSuZDgxH4HPxoPk?=
 =?us-ascii?Q?5r7lHlSJk4vL9DFRXCcsh0JpNGmQ8jsPC3bQU5dHkBzGLKyQHhLPFuXYAVmy?=
 =?us-ascii?Q?qg/MeA/LDtHd/oVBmOjtBRFCtM9pTXHs05UQfLWzik3Mlp51J+HiDbpL4vXv?=
 =?us-ascii?Q?Lqexw4GSjLZogtNOAlm2kcIAlkDuY1SCDkPt4qFvRnqO3DdWJfivUuk92oHe?=
 =?us-ascii?Q?bnx+25SyEsR7XGreNA9iBD4CWrjeyy8oqEDPKa10Vfr0zDdpxv/YO0+WGp99?=
 =?us-ascii?Q?+sxMAT+EK6GhsZ5iboZVCfh9iftzvyWfgF1Bsp7xrHlJFchYpYUtEyXsCKWa?=
 =?us-ascii?Q?F2W+ur3viGUkh2VZ8Xc9eCS+luU52iA+jerTSINiC2JMGv/+ycmi70MpTxWX?=
 =?us-ascii?Q?jptic4GPfD/wsuYYZrk3ejKKMjo8PSYV5hwVkQHmi7eGLdOxSbRN/bRsCwSA?=
 =?us-ascii?Q?FXOge6GvPWe1hdgkPPvTJSBj3DtpyktfoMoHc+G13qkw6Ya/QQWyRr0xezbP?=
 =?us-ascii?Q?oE+VYu9doCOAOOZ3C8zwm1r3F7GgHALsH+gYrAyDcqDgRV8b11hdGziCHp16?=
 =?us-ascii?Q?95LvE/8wJRB4oFNsUMrTG1IKDquGHwyXN4rPAJXurfvS9n6ghWIa1zegtRWc?=
 =?us-ascii?Q?kDAVqNRrY53uZo6hHD/gc/AYMhzR//0hPZwp83vWgCMa/kUjKunQgFbauFxu?=
 =?us-ascii?Q?zATRaWKpSygoElt1AC7X5QHWR/jY2gyku/OyBeEmUIfQio9vHJbSEoeAp3EJ?=
 =?us-ascii?Q?aIjVxH6Xbs1d6wEgHCRpK/6qkQd2Npwj+wulQtYjEYpO1N5vHMcjdmS0TInn?=
 =?us-ascii?Q?UTSsdFzao5luvd8I+pfRenKINVA2cbJPzCOBs47MjQk+veC0zEYhE6xIQ+Bb?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d198c3ec-b37f-4d9b-abe2-08dd6cadc7d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:32:59.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJzr4CYT0xNFjfeg6z9fHM8AijCi8ZRF7mJ0frqrfrwTm1yTao4hMiqdo+hLdx3SvU1ngN7alAmrF+BUxZDcUkC3sTacbe1GAp8YAPKAHXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add helper function to retrieve a feature entry from the supported
> features list, if supported.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/core.h     |  2 ++
>  drivers/cxl/core/features.c | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1803aedb25ca..16bc717376fc 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -123,6 +123,8 @@ int cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  
>  #ifdef CONFIG_CXL_FEATURES
> +struct cxl_feat_entry *cxl_get_feature_entry(struct cxl_dev_state *cxlds,
> +					     const uuid_t *feat_uuid);

It is unfortunate that this naming choice is too similar to
cxl_get_feature(). However, as I go to suggest a new name I find that
this is a duplicate of get_support_feature_info() in Dave's fwctl
series. Just drop this patch in favor of that.

