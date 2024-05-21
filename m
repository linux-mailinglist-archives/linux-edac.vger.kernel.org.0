Return-Path: <linux-edac+bounces-1086-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EC48CB47C
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B221C2117F
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2024 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D041494C0;
	Tue, 21 May 2024 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl0UBOez"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBE1482E7;
	Tue, 21 May 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321523; cv=fail; b=sIvMoFBAwoGcLihvSluUHLfjP1Mha9Saudbd/B4lg0OZThl9x4PiMm7XXI7MkKMm6TtOOM7yPrszcS1hSa7uXA9Tpi+ysXatpjcvNFhNuz9NHGloA08QE3C528C6/nnliUXiLOtG5UzsMNgq+qfNx6t4JyLonW/5XX74MvdMTJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321523; c=relaxed/simple;
	bh=P/FWuFKiMv6WYfN3iUOR/GXxuPZKU9QjH8RFU5rlAOI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NCusaPsfNuwpisZrydcawTtm5kh0h2IWJbH0+V7J+VAHlnEd2g9yS7kBFeFszC5I+lnotS6gxFQHuKX7mfBoE9cmvVqA0i0vtf8pbEpWhdKUib1poogNruNWiuqtWOxrHLvE6vuJp4JT99KD3RQ8IyVwF7fjcq/FMwM/ihLGlw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl0UBOez; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716321520; x=1747857520;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=P/FWuFKiMv6WYfN3iUOR/GXxuPZKU9QjH8RFU5rlAOI=;
  b=Nl0UBOezrQzJMszqt+9IY7y4zFuDNl/BwNDOmofw+NoKn1OGyqL5Hjx0
   3zr2+1l94cGHQAwPCgFTwCynBHoUwrR2lXlgNo950MOJjm/ObKm85+tJn
   q9CIqVXkrArngjPVzkESD84q1J+XdO5olVaQC0QyQV3JHuGd3vMaW+k/F
   vttqFeW6CvWH0eak8aaXi8llfNdDQ8dyGIrLfZlJrzzRjNF5JEHFFs8Q+
   0FwO/JXhyNP5Y8MIkRsezbDxxwUFpcWMf3SKJdYtaUz/uu7NkB/Tfkz+d
   z2hCltEW2BIms3Q06STQuCW/sRRXhGaxsqbMZb028UNueUoAFR5RlELqY
   w==;
X-CSE-ConnectionGUID: Dp2HSNNpT9GXmeledutbFg==
X-CSE-MsgGUID: XMPrHrzyRY6NCWbFYehxXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37922165"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37922165"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:58:40 -0700
X-CSE-ConnectionGUID: hEx4YyJCSS2OVR6WCJ2How==
X-CSE-MsgGUID: x4SH4qUsSG+hSGGPr3h4dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32953032"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 12:58:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 12:58:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 12:58:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 12:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5I2ex4Q9nSVSXZ/QP1kGUrxehToYeK/lZH45cEtXYskTsd9grc0eCjCpHuMj8uzT/3d24sVUubnj5f+kx/7QH/Cvcy622Anb14xG/PMAwPH8OxH8PB8/SF9VN0X4ci0LH6GByYOYtdHAVtkuKJqyrKQnUEXG7DvcsEUdfLqDlR6Zslh2uv/XkK09/duYDIGqU+nmJHBfZq7d/f2Avu3nVGUTGhLHI3+sIaHDoNwjaWQsQRiX6yszdwN/+69uJBVrZMpxhZ1STF2IRsmLrbvB+gvc1hBgzi9sjprkn+N/kYa2rN+OujCmXMeUmjpsvwMNSQzIx3B8ooDu6GyND99zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6B34R9oMBWxdz5PR9NmocO6GlqNj/RHHePsGjKSf1Y=;
 b=Mf1GcRW5EhZoktmA3/FgzBzEJIMpMtjxK3HjlSOW+TjyQwVcVzBINA2Vj+ZIChB5YlwLiTaQ0P0i2oek8VFqO/ZxFURejJZAXVrUm7giEjbiyWco0glhVq6ZaFin61EMos304L6OmlZZ+2YMHvJA9jhj0ciU2tpPRcSkPTAXTGC1gEpQyPhcTWwsSeGmehSKBrCf0gYg5bJPl89f7f/0J/RZ6bKukMLYhf+eWdbgHBP1esdzxLcwgsr+3UETccDQAifPPhyWhC5LyPwBvQjYbspEbbL5tGSJ1ImfVr3JvwfC+KXd+pUM7NbBe79+egC7bzqClWMF9CR/NYPxU+/DtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 21 May
 2024 19:58:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 19:58:37 +0000
Date: Tue, 21 May 2024 12:58:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH v2 2/3] ACPI: extlog: Trace CPER PCI Express Error
 Section
Message-ID: <664cfcea6c886_2c262943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <20240510112740.667445-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240510112740.667445-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf3690f-9a5a-4778-7220-08dc79d06702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCpojNl/4dVA6ehEfZS37euqM+72vHgYDtBi6HJGP0kiccH1aTb/dX97bjhm?=
 =?us-ascii?Q?BN/ynmzLQsku2T4cQ5JYfLhBoCdXunkqeMk2nqFF/8PBneNi0pBK/UWLZFZY?=
 =?us-ascii?Q?HWTcrgNLL4gWbccmnmA5RG2ST4y5d3o6PNmQqgLRHbupN0rCBAfCJjQNQ3ZX?=
 =?us-ascii?Q?2+nTYXDDmYaHEyCsJilxg+FXXdzhZOfr2ENgOLShCm4/NNOaPiTlUM3MCYr0?=
 =?us-ascii?Q?X1VHegaLZujDXDPWlBM3wrHgW0ChxkqwlrK2So4UMK4j2kBYF7re6WzR+0V/?=
 =?us-ascii?Q?Mn25ztkbP6zVpGp0A/EklnFW+WBcnAMznrnG/xF316MBbAhy/34IdVzpO2mZ?=
 =?us-ascii?Q?xojbvfvvEWL+DIgSww94aj/pIxWvAlpBo/6iAbxb3n3p1/gL2RYD7qSjDozf?=
 =?us-ascii?Q?cIa3Yowg4ME2BbB1LlxXb8PGAt8e0uXfKnzI/e5QBkn0sK4Ohp0rCnYWXabh?=
 =?us-ascii?Q?KfVEWop1u3rcmP4WZC254+/sT7IQzRPOWylfZJdal2oLKXW2+ZZ7PPPUy0km?=
 =?us-ascii?Q?HHmNhzLyAlBciArXXukTfamEbtifNwI/OQOclh3PB9Y5A8/lDxSBJw7tMkRB?=
 =?us-ascii?Q?jyaV8XhZ84qbUVv8Qe+CXbCR6Dg0n9XTssGbhBglnhT7mYUdymL78aqiW/UN?=
 =?us-ascii?Q?T1AdBMxR0Xp5JdzcYzee0iqq335gegJQEgK2/+KpRGfJkY0XryZ8IzAs3nx6?=
 =?us-ascii?Q?vAkS+2Cc4d5tailEWcgyron4j0puuB6UzEFJ9tgVBlGTArUVkP14hrQArzSs?=
 =?us-ascii?Q?250LOjX/aiiha9lDm5OggljbM6lXG0sIlSuvNjxADnNBC0AL6CEdL1i1FYGB?=
 =?us-ascii?Q?yp8qLXwkwiCiyOm+cjuFp9pEtZOA5L96XQ7xJSBLtXta/55j5s+S3bI4V1/C?=
 =?us-ascii?Q?cyVxg7Lq1vSAyD78F/4AB4yeFSPxyQf2Mw4LuFQz1t41LULsD34q2zO5Tz3V?=
 =?us-ascii?Q?elbUFxjdJe+zJ6EvlyzPa8Y82zKyzI6IaUyIsHa1WZodLrVzMmJS7+ciNiGB?=
 =?us-ascii?Q?8RfWZIhaloNz2faheh9Tt3NBJsuSeSQq/MXd77u5Zj8J45M5ZmMkskZ9Od80?=
 =?us-ascii?Q?aCyCsuWxrCMNoliI5xeAwLEBr7GweTRk6Byu1sGWkNRMU8PnY0+yc3AzeIBD?=
 =?us-ascii?Q?h8CgJjRmbXfZq/fYnHU8iaOc6+g7soDrGL5ZK0Qre6LKATQt6Rhw8o3v9u35?=
 =?us-ascii?Q?ZG6mDhaxpN9GA4CBxvuPgAL4NCQr1Uxbs46eoNtTp0snOnFOS4+IDfHPz42U?=
 =?us-ascii?Q?Jqa31Mg2RPAWLtdm+uiJFxAvpWD3gRf3M+VpOd48Vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIfwMiRQrq9WiO8tNsTeUTS1dzX8ICbwxemmAe8qF0yDSdq9HKCgQ7Fsdkkf?=
 =?us-ascii?Q?604+Wh4qH4BrNiczJQTXJJYSzBsel360ZLCBc5Pxo2zvXzXAwri8+6wDmDtA?=
 =?us-ascii?Q?xpZJgQdzHpsOgwiOnN2JfauRM0M4ASbKO10Pmh0gsSBin4Jz+e9gXG3je2VN?=
 =?us-ascii?Q?RS6FIRr6F2egGR7n/UCwanOO9/oqq91Guu+P+fE93IjEyNyjaMXuFBuGMG3c?=
 =?us-ascii?Q?vcu4EZ0yM4Su4T7o/BdSuDkvHwwZHzjERFT8m8g6k6er8nhHqEw1+VrwpDg3?=
 =?us-ascii?Q?jxBP8Rq6CS21vTzY3FRTOXMfLGd5ZYfRLkHIOs/fAiacEVfMFjOSim3gdPNn?=
 =?us-ascii?Q?5HSB5xOMjqF+55H0kyZCMp84eP6qeP8MHN6jupIOugJ9WrHiJ6AC27eQC14C?=
 =?us-ascii?Q?eXYkR9VaxAn6BuGaggzJUQQu1QfPtRrz5imojrfCqq/5zG2aid34IwBehssh?=
 =?us-ascii?Q?AU5Llmz0xuLocK/sxjOBqE7CUv/u0T7WxFE6umCR4CiFzfMRrec9gA5lFCCn?=
 =?us-ascii?Q?B1a/B9Qr+Ax+9sx/CUHkBKHG6cpUayWoe5mr0V81wuHhQvkdeXf+F4CuG5nR?=
 =?us-ascii?Q?0xvQZS6QZfxIFusAv+kQ1qKCC15AjulBBe0LYeTJbtQI6ctk3jda2LAh64W3?=
 =?us-ascii?Q?iNguWeLNQ8khWRxfZHruOc0NtHuSaSPGntA3y5Rw4H8Ec5FyezaL2J78O3+V?=
 =?us-ascii?Q?S2XtVMPVwFrF71czKF0gi/Jz70tqHtRYH9N7OpZqIs/03Ks9czaKdwM+B8tg?=
 =?us-ascii?Q?sYtaS45vrGyHrKE4GzVF//fIyHm6vAKrAqL6h/7vNXaRJouyEHb1lgcmYWqD?=
 =?us-ascii?Q?DhoNY4XwnCj3siV5p0rWW/ZgVAlJQyYyZqE0/1fUV/FtyDrUFUlkaqBBApxZ?=
 =?us-ascii?Q?L6ItreCOQSIuS86dFAyk8w3fx5sj6e4i69S4j9/GhC8MzOdGunprT3sCOAR2?=
 =?us-ascii?Q?NgFzwMNJZLu5oYOhM5Std1TbZzG8Q7PSGZEAu16TUgkd7MFpS1ultudgwFu3?=
 =?us-ascii?Q?lkXsnW/jdgcLI3aAf6nifNqIBGXjY51of080my9cxvZC8J8KBnHhjOZMvMjH?=
 =?us-ascii?Q?uvOs5jkpRf2XAYuzKV+PYp1nEbowdEB/pV0EbWNc+Fs+k3tYHJXssnpMKeHD?=
 =?us-ascii?Q?w73ZyQ2TWCJrp2SziRFPG1slb9Mvn+MsN5Z2qUye+e4aQVmhEqozs3h6q7du?=
 =?us-ascii?Q?eICCWpohYVZRG1c6VTQHAbOHbfSl1so1VQ8l+mApoucX577VxZnF5ePn4FOV?=
 =?us-ascii?Q?uSEAk89Uc/DEJ5egS6OMssVHO+wFgcqX6cOQvevNInPadLbWSXHuIjyqOKBc?=
 =?us-ascii?Q?xyNpJf0oX5HjYA4ki/ZKm0145e3TS0Rs1wudOxWP4cskqrc1I1k3sxoBxCHX?=
 =?us-ascii?Q?vbGME6mtx6Ax0YFaiAuJoaZo6Kbl8J/kZ52G/yFrZrRhgWSny+DBziH9gKs5?=
 =?us-ascii?Q?jeTT8eAo1k2cdHj4shLDTy4ByJVljaVW61omwcd91knlrstDK8T8KWjZM0nP?=
 =?us-ascii?Q?gbAj83z12hQFNyG41Fvv+4VwFsFXYSeXRWb7XI0m4DWIOjSIvh/50d1Mzxbi?=
 =?us-ascii?Q?oKsVXXZmGNH7EHhi7e9Ak9FZqnbNDJxW5JRgqSJAqJoKyQ3XlvEyaAMjY5ik?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf3690f-9a5a-4778-7220-08dc79d06702
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 19:58:37.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmkSlLWJpZDx5EIFmJ2vOvM3A5y9v5SHRvYzaipuHhWSl3/rDqXoh9zgXKlNijBvqmQh2kqUWzJukcEzJDOtVrI59mTruTqj5LDwf62CN0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
> v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
> the similar ghes_do_proc() (GHES) prints to kernel log and calls
> pci_print_aer() to report via the ftrace infrastructure.
> 
> Add support to report the CPER PCIe Error section also via the ftrace
> infrastructure by calling pci_print_aer() to make ELOG act consistently
> with GHES.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 4e62d7235d33..fb7b0c73f86a 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -131,6 +131,36 @@ static int print_extlog_rcd(const char *pfx,
>  	return 1;
>  }
>  
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER

Whenever possible do not use ifdef in C files, see "21) Conditional Compilation"
in coding style.

I suspect the issue here is that pci_print_aer() is not always defined, but the
solution there is something like:

diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..6ff54197480d 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -42,16 +42,20 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                   struct aer_capability_regs *aer);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
        return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                                struct aer_capability_regs *aer)
+{
+}
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-                   struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
                       int severity, struct aer_capability_regs *aer_regs);


> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		aer_severity = cper_severity_to_aer(severity);
> +		aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +		domain = pcie_err->device_id.segment;
> +		bus = pcie_err->device_id.bus;
> +		devfn = PCI_DEVFN(pcie_err->device_id.device,
> +				  pcie_err->device_id.function);
> +		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);

This pci_get_domain_bus_and_slot() takes a refernce on @pdev that reference
needs to be dropped after operations on @pdev are complete.

> +		if (!pdev) {
> +			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> +			       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));

I am not sure this error message is useful. I see this was copied from
aer_recover_work_func(). I wonder if a better approach is to just teach
pci_print_aer() to be tolerant of a NULL @pdev argument.

Most of what pci_print_aer() is just a device name which can be recreated as:

sprintf(name, "%04x:%02x:%02x.%d", domain, bus, PCI_SLOT(dev->devfn),
        PCI_FUNC(dev->devfn));

For now, I would just return if a device cannot be found, and skip the print.

> +	}
> +#endif
> +}
> +
>  static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			void *data)
>  {
> @@ -182,6 +212,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +			extlog_print_pcie(pcie_err, gdata->error_severity);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> @@ -331,3 +365,4 @@ module_exit(extlog_exit);
>  MODULE_AUTHOR("Chen, Gong <gong.chen@intel.com>");
>  MODULE_DESCRIPTION("Extended MCA Error Log Driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);

This is awkward now that pci_print_aer() is consumed by a module that is not
"CXL", so perhaps we should either drop the namespacing of the pci_print_aer()
symbol or put it in its own namespace. I think the former is the way to go.

