Return-Path: <linux-edac+bounces-3403-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0079A720F9
	for <lists+linux-edac@lfdr.de>; Wed, 26 Mar 2025 22:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB103BCFE3
	for <lists+linux-edac@lfdr.de>; Wed, 26 Mar 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5325DD12;
	Wed, 26 Mar 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwde60BS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FEC2AD02;
	Wed, 26 Mar 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025612; cv=fail; b=SXhPeu9rmOfKtpoBGMxGVBDayb2/DqCh+ijHe3QWCrXDRM+7a75xIQaNwRcYJ6ZxkxzOa5+8szRDEs2AbXn09EVw8ysc8eGT3QYtwDkP0eXf8Pi8pui9ogevL4faLCwbevxJ4d93dIjaaha+lcS1DLOpAUKD46q6qn9NQFYGFAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025612; c=relaxed/simple;
	bh=XxBBUbNsN/+kyP8N5Q+IRnxZUfiXs+bWrD446ol4urw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXiFwhC3pJAkP/fQBJ6ri267lEDfXXVzPJwSCEbg6JL+0B5Io93HgVYYoQGNPARWkQYBwdhn98Mp7+hd2SrwHjxUsQaJpy4DS8L0n44DjLxzVZA0BpCDeFDRPAKddR+JWbft2c8kHIwGJB9epGn63qabkXsuKEOL24KFndGxrEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwde60BS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743025611; x=1774561611;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XxBBUbNsN/+kyP8N5Q+IRnxZUfiXs+bWrD446ol4urw=;
  b=fwde60BS9VZdimYfLPflvug72wIW/gjme2Eo4lg7HYIezAxpa79eAASu
   g0ZqrrW01a5pXYO7HaNdrUbBhIeY+PdFN4korWEGE6ErkJSBMqpceBmwh
   o/2IF48LrEsV5CKyhHuKTgYRAt3GD/7I4+PHfGe3rIicON8Ukaw2HOhtL
   vB3AqXB72jEP+WvOlzmQiCtDm31bSyG442VjekHlFR5hcmwG1FVJgF1Wd
   lxoeTqp5TZ9KAeD9JDnAYtMve7CrCwM0Hbt2xLF+kPqsr+/XjWUxLmuTp
   HywXNEX5FymRHAjyoiLQuu9S6glFuiM8HZDuU9X42OOEcI/FLg0rUczf4
   Q==;
X-CSE-ConnectionGUID: t/hrGFzwQnOU3GRfGmMfgQ==
X-CSE-MsgGUID: WITJE1gUSUuEmNkQB21XtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61734094"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="61734094"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:46:50 -0700
X-CSE-ConnectionGUID: jzPdhZdzSSGlp4Y5njSwrg==
X-CSE-MsgGUID: JPj8EbvoReOdval7A67tkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129080771"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 14:46:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 14:46:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 14:46:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 14:46:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWgoCFO2KqyM8iY6V0Eq+f3/e9PUZq85oWHvGkyrFr6MPs1JxuXxxhYnypcx10MH9vBMDGfAdK6JDxMprfyXVpKbs3sG5eiOMFgg3p6NfNm7dFqUkXXwoH1mzPWhGIITkekv4htANUpws6Syy6HHQb3iOMZiuvaUHkuyLUypn+ixNzr6Ou8nm42ftDgcuyu3MEIiwYvnsY9UDB1xyYiehTl5rZu3ff2vZ9dLVk7UM91kiNl5KnFJB9rgmbGtA0k/ZS4x1iPky33GJ+7I0XKNfs0RU2avsYNBaqnLPA8+p+skM+cQ5FhoiwOQDHEoJ3S6y8DHLtb16XiELe9HcTUc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL/dmGho0NtlU1OsWwzlfZC+tjiMPG/lG9x754ctklM=;
 b=Qt8WVqMq2TFshJvkS8JdcMu3djUjv+8NG/PpTXtpUBhhrMRHIMHIo9J3+eJSS+zqbHuKXG3It6ySNI2yLGTFOmb8VfW+8E9xcICgHq1CJEMeZoILGynLqYB2OSkfmNp8+hlSePL7pVD0cn2t/ard2jR7MoHnJZIGRmLdMvNylMhpftM/2sQUQ+kJFjkxbBoqTNYAc03gW8kPmjssKmbobCLjvHs/tM1fAN9raNO7qpDr1q3muRdfrRFg9GAaRmf3tAk+7uWOTIr8BeOLgtRBbC+3Erb45GVN54NKASIzrip6yTEG9CMycTYPYW1SzTyzJLBxqDTj8SaaFom0Ob3LKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 21:46:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 21:46:27 +0000
Date: Wed, 26 Mar 2025 17:46:21 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/8] EDAC: Update documentation for the CXL memory
 patrol scrub control feature
Message-ID: <67e475add3300_152c294e6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-3-shiju.jose@huawei.com>
 <20250321100305.000018d2@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321100305.000018d2@huawei.com>
X-ClientProxiedBy: MN2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:208:23c::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e217d1-026b-4aa1-41f4-08dd6cafa990
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ouwWRC9xfQwybXMsTfWQ2ykoLP+x+BRNA7aI+grzm+C+k3eZyhwDVe5wEP?=
 =?iso-8859-1?Q?4A5MmULSTk0pte/yYCSpAYHMI7hJa/z+LAOh9UxyaZQu6wcbjJYd3Ywht2?=
 =?iso-8859-1?Q?2pfc0VaT+RFT3LCzQznbcmE8h50oDMADLJP0rFHiRTX+h6y/6CkPZGz8Dm?=
 =?iso-8859-1?Q?m4UIt8SX7ko7VHh/sOfTUdf4h8WyxRXZs7uvZcqk8LKQjIO8YKUb929SSl?=
 =?iso-8859-1?Q?9cVCAUDpQ+V1luj/MljnWhRHsW8R7s3JKga6QaHcoAx1Y6HvsBOwH7rZi4?=
 =?iso-8859-1?Q?5vXYbl1ukyvgLL5MUWiuXIWWILsQKaWsR+FE0oHxPVXSLmSqv0aX494hU+?=
 =?iso-8859-1?Q?XwpAdRU4CKuws4pwnNpkk1UdNqFyeHzFckHsyOGE52Ogqg/VQEEAsBIa5s?=
 =?iso-8859-1?Q?ekO5P0JEH4VceWaDjvDIsYXMD69kwaGSk6iwCEoghIZ/EbLmHEa1YJvtSF?=
 =?iso-8859-1?Q?NDgEf7obhL4iFwvU5zoCw8ClYOpqAhUU8xn95u0Sl2vZepPti2Sd5K+MOA?=
 =?iso-8859-1?Q?sdxhR5mJZszOklvZTcbrSzzkIvViolfs7pCQkADCgCR95IFA72H5+JcAbi?=
 =?iso-8859-1?Q?RpbXBdX1OD5seInQjIB1979lj8CnfE3rcoWKY5jbWO182ynySfq09E5mm/?=
 =?iso-8859-1?Q?r/lM+Oq1FTqyiGgEs+AYPy9j2fZEBnkRjnuGrx4jZlEyGHGK7Xsl5QwIBR?=
 =?iso-8859-1?Q?+IP4Ybo98+bLa2JHB5MC83ry6YxPYbVjYuc2YbQPYtrrFd5XNTZjWVKUhs?=
 =?iso-8859-1?Q?saE9XRc7RsjEIveXsz93vdbj0m6GFwkkEF47Oi9yTVw3iQmRGZcFVlOpXL?=
 =?iso-8859-1?Q?uu+dto0gB7VOt0z9p0nAgsy8brc5GuQ3LtrGC9OHOJzv/53tvnO55gcVWF?=
 =?iso-8859-1?Q?R5baSIw7X6fChUxasx01L4srrfIinniGQIdLiPHwe2xQHRv5zEFw5UtUnr?=
 =?iso-8859-1?Q?iLLrIcyGtN0xwl0H7yzl4iKMdsJbtBCnMjbAAEN17TC//0+R29FV/VM3ii?=
 =?iso-8859-1?Q?J+meWe0BtLeGH0Ui9gOAP8wY29AnHKcbbjdewgBx9qDnNcg65BYS0Ex4Vs?=
 =?iso-8859-1?Q?meOdJNmHxcCQ+VzcPwFvyJr3gq9cqbCeGOqZ1B+TRGrN0jeS2YynIofzzh?=
 =?iso-8859-1?Q?Od6Xt1gqC0AlLzwr3rHyoMvo3PoqVtoKEQXJ9neZEiGHoVCgmZSrJtTZq+?=
 =?iso-8859-1?Q?TIBhDmGfe5uZI00N1pDi6EKQBrBz70Y+eG5qOujMzsR8DvMXCgb4ZEOKhK?=
 =?iso-8859-1?Q?aEHQqlWYQgTAqGCd7AwvnJOw4wj4yDhM0pV0Gnoinx3ZbEUfpIbCe7Augc?=
 =?iso-8859-1?Q?w0xWBhr4dyf9BPSTiXYUyYmxswPSx8goFTToNgN7rxUaGvL+ACzwHx9ck6?=
 =?iso-8859-1?Q?E8RXLYDpq7JT7H7tCL6L6tRYRIQwndvmVLnQqZNIVXU0+mCpNKgePiigWY?=
 =?iso-8859-1?Q?yS+9bPKxyYn8PLZg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cXBKgR3mtFfsxNNkoVZXHhublfS5i3gOPrUjp60Lnqf0PEzb0PTGgQsQe1?=
 =?iso-8859-1?Q?FW1FHI+QMF4wxtON15zYQdFVgl8Z9axjUwBHhlviugfG7yBrp6wJVKbn0G?=
 =?iso-8859-1?Q?XtarYxAYevJqzGnYbuata+EhWYnjPYEajm513Nf/ubbctqo4ueA55shDqb?=
 =?iso-8859-1?Q?QOPUsBBfGzc/w7PGeWU0qBXtZkOOpsuvnY3cPnEqHOyy9OwlJ87KCVkhch?=
 =?iso-8859-1?Q?fnrIj1tldTVICYJxR2FVAnJfFa9l1ezJRCwzqoolw3x76pfFuwuPjWq4bZ?=
 =?iso-8859-1?Q?SOH2aqSDUJLP1Yt7DqvcEY7zOGEoFqwPRgbp19W39kPx9p0kTknBqKvahU?=
 =?iso-8859-1?Q?lnmT93QBwxJaZNMVxWd5MXzB8XJfLMpgZox67dgCO6iZZP5idGmQcG0L7Y?=
 =?iso-8859-1?Q?7EP2qgcX0Z7sJCl0pnChAdbUDXvWRnY6qYeKyTRduubTJ3PSQRiGx0/I5U?=
 =?iso-8859-1?Q?xly4uFw410QNFM+AR4rUVnZ+jGtMCc6i17dynERgepsazULEgDeMYL3QsX?=
 =?iso-8859-1?Q?V4dCF41YrxvdD3Fs6qMomPsdYI3LIuajaqRZsGWzDlrnrVZQr8XxlP4CSP?=
 =?iso-8859-1?Q?bTDmgyZCwqeUKRmLr5pB0/41WHosvz8+xf+z6tItcaVT2iY0UYaKrMDZpc?=
 =?iso-8859-1?Q?bg9lNgC6qWYodiRzkgDnzQC5UmlCb3m6uyq1PjL8YvY2gkgBPQhGpyCfHy?=
 =?iso-8859-1?Q?BdxJ8Eiux3CDixOlKgqgT8DHv6Ec2WM4QjTCYUxtKfec7k0dpP/n2zc9Gw?=
 =?iso-8859-1?Q?x5zcJQA+6keDrssKzJdHR7yQU+2T0wTcV8spXnfMDjK66oQoXrGeTV+zZw?=
 =?iso-8859-1?Q?KXDHYwp9k10WmkLeZBm//5Wa4dAWfhxfZLAzE94gD9EBQQoc0xYYZBEWzM?=
 =?iso-8859-1?Q?fB+OxhAKVZjp4jqX+iorHwbUxgmdpwZ4UGhCSiYR67eYeGdZaZw0U80AzA?=
 =?iso-8859-1?Q?kmyTyQX8rBamjXHpgCwhpBldGkk9wxP1kIjEFSqkmn7ckZdhz66MqPPvTm?=
 =?iso-8859-1?Q?9vv1D/XrwGe9gI7h32Siy4nRGl+i7ZLAU1FyoKIooxux8pzjkqojHXxA8V?=
 =?iso-8859-1?Q?nQpHRh31VsdQr8bHueF6OJBooJ9YsuJvPN/zJ1lZJsUQx/tOptm3jtUOjq?=
 =?iso-8859-1?Q?Yt/ig6RE+D5q53AlcXzYTnz3j7yE6bNXK4gVIVOtzuV317Ax1aTdXczTEF?=
 =?iso-8859-1?Q?dGqWnORGIuant/2OaqF4/LVfasWPxWWo5SmUNxKtQfyK7qv513oWsxgqKu?=
 =?iso-8859-1?Q?eVb4cTkyO4SAbQzqclkaeKroQlYOxZsqTfiHZudFr+Wmu3T2qqk8OnKKxf?=
 =?iso-8859-1?Q?6gChebPEqD+gxc7tSM+8vfmLBTiaOVQHthWjlhZO16T6nxxXoJj+4+MDB3?=
 =?iso-8859-1?Q?iDugXX4FvMcDuCqXPUY/XTIvgLSFFIbEEXaYD1ZgRd2d1M7k24k+Dh53V6?=
 =?iso-8859-1?Q?d985YLDxTvyt4Ab0y2Df1En3uJ6/Bl+YzYuyWLyIHzb41IykERmHMmVytv?=
 =?iso-8859-1?Q?1sYumQBRjm3ApMO9Lu3gYt4C8IG0TIWAR9CWDS/73F534AYaKvT9hWFcbY?=
 =?iso-8859-1?Q?xIZZ9D5H9iN3j4UW8C9lMysi40uTfrnnbIaF0J/3Ja4jKldk2ufdoWFh8L?=
 =?iso-8859-1?Q?sDH+44pLYdPoXvN+X6bgRuG5JNakEX/zIfySsRqcSao0L45rQ/42zcQg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e217d1-026b-4aa1-41f4-08dd6cafa990
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 21:46:27.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BfvwNM2b5k5Fe4pHn7uU0s1BCO5pcylLj8q5Zk4O3gBZ3pE+AqXL0BT2FxSyyeUUMtIBQFXp1zJa5Z6uRfcNdq32oPX8JNpYAG5DKZdz3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 20 Mar 2025 18:04:39 +0000
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > Update the Documentation/edac/scrub.rst to include descriptions and
> > policies for CXL memory device-based and CXL region-based patrol scrub
> > control.
> > 
> > Note: This may require inputs from CXL memory experts regarding
> > region-based scrubbing policies.
> 
> So I suggested the region interfaces in the first place.  It's all about
> usecases and 'why' we might increase the scrub rate.
> Ultimately the hardware is controlled in a device wide way, so we could
> have made it complex userspace problem to deal with it on a perf device.
> The region interfaces are there as a simplification not because they
> are strictly necessary.
> 
> Anyhow, the use cases:
> 
> 1) Scrubbing because a device is showing unexpectedly high errors.  That
>    control needs to be at device granularity.  If one device in an interleave
>    set (backing a region) is dodgy, why make them all do more work?
> 
> 2) Scrubbing may apply to memory that isn't online at all yet.  Nice to know
>    if we have a problem before we start using it!  Likely this is setting
>    system wide defaults on boot.
> 
> 3) Scrubbing at higher rate because software has decided that we want
>    more reliability for particular data.  I've been calling this
>    Differentiated Reliability.  That data sits in a region which
>    may cover part of multiple devices. The region interfaces are about
>    supporting this use case.
> 
> So now the question is what do we do if both interfaces are poked
> because someone cares simultaneously about 1 and 3?
> 
> I'd suggest just laying out a set for rules on how to set the scrub rates
> for any mixture of requirements, rather than making the driver work out
> the optimum combination.
>  
> > 
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > ---
> >  Documentation/edac/scrub.rst | 47 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> > index daab929cdba1..d1c02bd90090 100644
> > --- a/Documentation/edac/scrub.rst
> > +++ b/Documentation/edac/scrub.rst
> > @@ -264,3 +264,51 @@ Sysfs files are documented in
> >  `Documentation/ABI/testing/sysfs-edac-scrub`
> >  
> >  `Documentation/ABI/testing/sysfs-edac-ecs`
> > +
> > +Examples
> > +--------
> > +
> > +The usage takes the form shown in these examples:
> > +
> > +1. CXL memory device patrol scrubber
> > +
> > +1.1 Device based scrubbing
> > +
> > +CXL memory is exposed to memory management subsystem and ultimately userspace
> > +via CXL devices.
> > +
> > +For cases where hardware interleave controls do not directly map to regions of
> > +Physical Address space, perhaps due to interleave the approach described in 
> > +1.2 Region based scrubbing section, which is specific to CXL regions should be
> > +followed.
> 
> These sentences end up a bit unwieldy. Perhaps simply a forwards reference.
> 
> When combining control via the device interfaces and region interfaces see
> 1.2 Region bases scrubbing.
> 
> 
>  
> > In those cases settings on the presented interface may interact with
> > +direct control via a device instance specific interface and care must be taken.
> > +
> > +Sysfs files for scrubbing are documented in
> > +`Documentation/ABI/testing/sysfs-edac-scrub`
> > +
> > +1.2. Region based scrubbing
> > +
> > +CXL memory is exposed to memory management subsystem and ultimately userspace
> > +via CXL regions. CXL Regions represent mapped memory capacity in system
> > +physical address space. These can incorporate one or more parts of multiple CXL
> > +memory devices with traffic interleaved across them. The user may want to control
> > +the scrub rate via this more abstract region instead of having to figure out the
> > +constituent devices and program them separately. The scrub rate for each device
> > +covers the whole device. Thus if multiple regions use parts of that device then
> > +requests for scrubbing of other regions may result in a higher scrub rate than
> > +requested for this specific region.
> > +
> > +1. When user sets scrub rate for a memory region, the scrub rate for all the CXL
> > +   memory devices interleaved under that region is updated with the same scrub
> > +   rate. 
> 
> Note that this may affect multiple regions.
> 
> > +
> > +2. When user sets scrub rate for a memory device, only the scrub rate for that
> > +   memory devices is updated though device may be part of a memory region and
> > +   does not change scrub rate of other memory devices of that memory region.
> > +
> > +3. Scrub rate of a CXL memory device may be set via EDAC device or region scrub
> > +   interface simultaneously. Care must be taken to prevent a race condition, or
> > +   only region-based setting may be allowed.
> 
> So is this saying if you want to mix and match, set region first then device
> next?  Can we just lay out the rules to set up a weird mixture.  We could
> add more smarts to the driver but do we care as mixing 1 and 3 above is probably
> unusual?
> 
> 1. Taking each region in turn from lowest desired scrub rate to highest and set
>    their scrub rates.  Later regions may override the scrub rate on individual
>    devices (and hence potentially whole regions).
> 
> 2. Take each device for which enhanced scrubbing is required (higher rate) and
>    set those scrub rates.  This will override the scrub rates of individual devices
>    leaving any that are not specifically set to scrub at the maximum rate required
>    for any of the regions they are involved in backing.

I would just say that last used interface wins and that the kernel
should probably emit an info message if someone mixes the interafces.
Something like:

"device scrub rate set by region%d rate overwritten with device local
scrub rate"

A similar message also applies when regionX setting and regionY setting
collides at the same device:

"device scrub rate set by region%d rate overwritten by region%d scrub
rate"

With that we at least have the chance to tell people that are confused
about their effective scrub rate to check for these conflicts in the
log, and otherwise push the conflict resolution problem to userspace
policy.

