Return-Path: <linux-edac+bounces-1050-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A38C3974
	for <lists+linux-edac@lfdr.de>; Mon, 13 May 2024 01:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35FD1F212CF
	for <lists+linux-edac@lfdr.de>; Sun, 12 May 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E847A79;
	Sun, 12 May 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cv41Pp0d"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030D256D;
	Sun, 12 May 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715557516; cv=fail; b=cVUvYQrFjf5Qu3Ln8MMuwCFfmI+8NdhM9+ufaL/HXjLvwvDCt5Xv43CKQiK5Yq2T9p+vuisWhwRnQKf7A1Q5j4qWdG6hi34VM1kW895SMXs9S39r1bieDRNatYfRSOngydhCz4Ccd8PDAX4Bqfs7QjPdwhuQMUtBRE+8ntSjF+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715557516; c=relaxed/simple;
	bh=UEmWN1EUTAo4DdKnG4D6ljl87wBb4yxIee5O/fvAv58=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T1a8l45DCjlZFRBXMI1XLlj9pIm6PFUnyPKomAOcuJAl8zLKivwNVCgjjS+Zg08r8MpoZOYiflQSVz7E3bVgcOSgShvx4LOuv3a3crL/GIOyCuk8rzhL7i0C2MeAp7ZOmqyHW7AHQk3vDjW9H1lAG0nCZHKFLbojtNSpYOE/hJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cv41Pp0d; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715557515; x=1747093515;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UEmWN1EUTAo4DdKnG4D6ljl87wBb4yxIee5O/fvAv58=;
  b=cv41Pp0dYHfvy61ug7QmsVPDv7rfwHGggCgiLA1sixBFoiojDdYm4Hf1
   ohfvGiGCWuzLMZAUEP198ub6Wau3OFrlkdMjz2ubUCkJYLvHg82IuC3A8
   ksikxlhv5C8X+6uA/tt7nRe1gVtdkbapTiFy88aexCXomkY7o9NaaLKIs
   Z7DKEfC8rBrouf7kNaWjqwHS66WpbvnKnWDBswauFfV3tYdYLdTDYR5Fx
   l7BeWzZ4juvZ1ahX/Dewt36lsJXV9XsW+LEmcdItGLWw1uGIWdblta/DP
   yryTRNOJxrK/b3N6rNepRPsSnvWa6w9jR0f1DsB/MJvkGXTdOOOzyMN3C
   g==;
X-CSE-ConnectionGUID: vebKbpaxRK+t3nwWFyn5Jw==
X-CSE-MsgGUID: LnRfORuORNu5Tx3dV7bSlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="15312216"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="15312216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:45:14 -0700
X-CSE-ConnectionGUID: Xub65FWnR9yU7Fmg2ZiBAA==
X-CSE-MsgGUID: tafac8F/Q5KUd6myoulBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30282135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 May 2024 16:45:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 16:45:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 12 May 2024 16:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 12 May 2024 16:45:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 12 May 2024 16:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHSDPZdy6vYQw+jsFaRvBtKwPs67joWaKY+in41adQL2OOgNA9SLQZKE8Hm/Ac/hb6Dth1LjMuAPcpkInT+XAJcPDOaNrViJNkjU5S+/4+j446u53nAud+EmA2LSbadsSE5cihSIOOAtbBKn1rPM28Z6eQv4IQ8Zx6LzmlIvfTVc82C0I7Ywe8oEmI/tSnAcU33DVktDJBQPtxEP2GDQ1Z/7bvJZWsmSqlZWLPT/1nLMGD7S33K6JIGyaG1oLfl2NBM9NfCNG5ih9p4iIuvSxcV8HUirEbsWFkSACdwhFwBeVGpedyvjZ+DzQiW4KEHOv3+sAjStftV0jD5oFbZdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G4d80LO78V+7DVaEqF5TGTLzg+YIgscizEHv69M1AU=;
 b=ahvI4HtgvyI4P1fGbYIFoWSHrgSTSHkLHvxaQA0kgl65mQFWhAgUHtbWfn+wl+f2UVkCBLnNjEYUZq5/2qNgsP0pX62K0CaG6Y8xQu93iP9u1pp/eKEhDRMR9ixt2ILRzOjYYRstONtjNMZdmhp1Rd1fNflsz9A81MIKlFHJALva+DJsw+yMhIH2cDMNFVDkU+m9XyRS9D8HWVt67+szwnX3AHek3tFqVZ+Jqo4mNY+8k4maE66KSwlAQ2ME8+RiAVO2Cl4K68m/MxuYFlql5SzCMIcmz+akiG5R+7jpVvJMSOjwCYO6/A2btG9LROv2uu3mg8msY695d9CSOrRmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 23:45:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 23:45:10 +0000
Date: Sun, 12 May 2024 16:45:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9632dca6-b2a1-43a1-f735-08dc72dd8f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NR7hmTfQNi284j+uHjkvJo1Qmk+cgNiI0LUF8FO1Zw9ALPuIUMQtK9n0/zBU?=
 =?us-ascii?Q?6Vr3ebxl4REMuRpFqclIFbcxo851MUXM3MOgPQtSySl9fo4i2jSOdk0/raza?=
 =?us-ascii?Q?bhczTqBf1oHyFJQsiuPoCjWlWTuaBppfvJ0QEHidro8+3mDHqv2U61c9tCwW?=
 =?us-ascii?Q?8J0/nfZaRbwsTK4NZoysiQpNmBWlapznLKHAzQVD083Vey3vzpd91dmjMX+g?=
 =?us-ascii?Q?0qLqGXaYynujNBG/zdwj7RU4y+wkTPFGevzvCluh+iFgYMUa8219h1Ty0Fsk?=
 =?us-ascii?Q?l5KiXYr8yjw5GCHBntpDchDT9veFe2Rpv0TvKtGYS4J1Jv/waolT3TPU6HR8?=
 =?us-ascii?Q?+jx6no5ql3gcPyRz0ZQ3DXsIjoC0XV5YnmMsiNEQLIDS/UAwD7AIFFdgbifh?=
 =?us-ascii?Q?1EmGwq37ZXd+EKfuDe7SA7RREi18QqcJj28YmUkJr32gpi6eGu47eHTYa7TJ?=
 =?us-ascii?Q?RhLfkZu7XWmi1E323XC3P6mRLtyw80g43+UcXPfnhWI1QZTmNL+byL4dH/Oe?=
 =?us-ascii?Q?eQOhnclzkajHendZsyT01bT0lKTXEeGewffGdnKmvHYQXZqa8Jl8c4q5YfWm?=
 =?us-ascii?Q?oLyHu6ndOmIhaOvkbSJKuUcgybuHcOQTQruSBIJfhP18b5R/nwEwmiFd8YgV?=
 =?us-ascii?Q?b4oW9tu98CMz7rUE+Kags3OvONkfo1m5X4+v8peVxY2E1j4GFhI+oQHhiNt5?=
 =?us-ascii?Q?ywwdAls2+FNyNstBn2Ijt6bDoCMwMSQEcCOSziimiAaeu+SoaF1+/jDXHF5I?=
 =?us-ascii?Q?I0uZAE/pb0Fa5o0fXTYXlnI0YkojxLqA8UDtniAQ+kIau7pFMzcfceb2jhqN?=
 =?us-ascii?Q?oFRMEGjcasiwVpyTtjthfflWXHo9N1Wsd1TTgYswWkZwHZmvCxSYVdzK6sYr?=
 =?us-ascii?Q?AXn4WcfTZH//+WkR5F3PgREMer9inLjucemzEi9I6jHkhrUm+Q0XznXsUU09?=
 =?us-ascii?Q?rqIKBZbbn2IAq6ZCHwavptP7IrU0tw/HgqzUsN/QQJK8yAsHS2c8u+SePelb?=
 =?us-ascii?Q?0RPEx3QfsvV/iqEPaVbn9XgnR3SZVEiGpXppKajpr26XtGlWy4As2aAGGcHd?=
 =?us-ascii?Q?IH6RON9ohYjGVY2ROmEX9CqfHRxab/czTvK9PG5mxZ2bg3L7omUN2HWLDOBb?=
 =?us-ascii?Q?AR+Zc7d7Wit6fRzcO+3EBbxXPd7RvdTZR0T0sB0cgbfx6wfEsF9ZcVUyt0nm?=
 =?us-ascii?Q?4TwCZwI2rhOWE+iYDNfYM1fuqisKNZ4fXxJzXwDZWqqCfPRDL4/f3gWSSWQD?=
 =?us-ascii?Q?+feJ/xQs9ov3YYb2laj+7e1VTlxrSrVaxadZtp71qQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6w3sucP3qMhUIo+LsyJBetnDEltCvMYxHw8m96FoSxDAEwks3aR9ZLnTpDgf?=
 =?us-ascii?Q?F3FINgvdvprJ1ADpB6SGCjrFaHmk3z5J4GH3fDwSu8CCRsIHHKaR1LjXqqOI?=
 =?us-ascii?Q?NL3Oo/GJiEi8FcPhcseLwZrCOxeixn69ZYpfVueY5ewPvtqZfhG1w762S9Md?=
 =?us-ascii?Q?hirkms7KWZejfUYeFBS4U9K6ahTv54Y5NjFjXLreTSuukXS6dPX0Wdu8v0DR?=
 =?us-ascii?Q?Nv1+U/v/V3avWm3NsziOwslGsFk4DEn6nYVUALt82o8Dv6eWCbpYdHkirtAt?=
 =?us-ascii?Q?EVjwdVkG4PulUn2YlYWKU/EI0NfcmmeYr89xfSBtErReJrAiq/pZ5Bd8Xyok?=
 =?us-ascii?Q?uflhT3EwNLESGbfkWmV9e0Uu6NGoUf0MUE/ITlQoqbvbbSHM/HhlZ5bavM0F?=
 =?us-ascii?Q?uRXK2tYcAuUkGhNTmVegxLPQN9xddiNUC+vupeaONGAprGI6Im/Z43tLxg1e?=
 =?us-ascii?Q?4ix0zcQGSqmVAe04U1cP0qGPEB5JoSkKlA+7Y3Lz7L3lTQoH6f0haXPv8jOs?=
 =?us-ascii?Q?QHxaPzafYoiDpA/Av2dJH4MSmG0RosGWWtVrcsblffXnyUnroj2E1NSGwZUg?=
 =?us-ascii?Q?34n24hbJ8T69nKtYEz7vOgYUNBqM5k/vb1Gurn2sUe4+Q1FeQ0EDIy9XAr/L?=
 =?us-ascii?Q?Iie2fBOe70AwDZ63Hi6E/yUlJYT7l5WUQN5jjz78um/uwL/AY/bK02YWo3uT?=
 =?us-ascii?Q?802SOivOfzQBq4aS+BFfg/Xlzhh3UPi3ZmN+L4w8mHD51a44mYHzPs1peOaA?=
 =?us-ascii?Q?nwveAMC975dpPyApJr5k4nTBy+1Sfs1e2UV8HM1qAPMJmYidjBylYKbSXmXF?=
 =?us-ascii?Q?tBbLjWhdoUqObRB2hAVFyCO7lZUuONuZCbcwQjsvZK2uacSfNx765dHzBDB0?=
 =?us-ascii?Q?n3MpbGuU5g5DcicXAYCJ3Ou2dEw18vLULfD47BMkLtAxkykgcXFT0/u1YFn3?=
 =?us-ascii?Q?JCTVoyOpbZQ2/8HpiEN65u5D5zvMthTWC63f+AF57ohCdQFA2Wt+4ehGc0Ue?=
 =?us-ascii?Q?k9tn/3tiNlp+cz+mfgZC9K9R7r2lpDBEH9l50QxZng6hqRTdfn+l8HNlww9J?=
 =?us-ascii?Q?WB64vX0g62lUKa3GtoGyA1WAbh8IJA5CqFYqIb5EdmvP9q8DvtGULIUhml75?=
 =?us-ascii?Q?UFfICaEzEOqOXZyveWq4uCgmuMUq+Q1grH89S/mWy0lm1MAYcMSxnEXBZzuj?=
 =?us-ascii?Q?1j0aYkutWYWodrOAU5ecFXCLGwT6seXRlPH/JCIA6uc7QuJLUHJFTtojCRMP?=
 =?us-ascii?Q?PfKC6VEu5hgvHwjnIsfcoaOZQAfyoDWNCJalguQqo6Hq8QiMeIJvZy1h2W3s?=
 =?us-ascii?Q?Uu31tD0kHOz2zg1BuxtBQe45lcibLs6PeAKTeR3/JEQGOYSBocjTSaPDxiAL?=
 =?us-ascii?Q?nFDk9Ka1BYW9eVUnVzlCLgxis4kFVXgmGy2UEWfuhPsMmg4tMO9PJTgl0N/0?=
 =?us-ascii?Q?Bv9zOZPS0FrjQDgcKloYCdb2CtOT+fxIDAkuEVCYBzA56TSVh4cfSW/N9s+P?=
 =?us-ascii?Q?DfXdBoCtXrPieUd17+yXGYrrRqgGkhdELojzTiWkiY8s3BdfVUXWohBcYToS?=
 =?us-ascii?Q?75sILR2Lob/gV1mV/f1t/D4TyjGAZmINo3XODBDGMVwyPDIfXEDMA/LemdKs?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9632dca6-b2a1-43a1-f735-08dc72dd8f8d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 23:45:10.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPITneHxuYlwXpfN3oTjeV2bstsZ283/Waaj6Nzokb3e17rqLmxXWsZcXZIh6N6y8YsXCj+unuqVotZymUcKaJmoknl8ovU1yf4beM5sbIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> On Fri, May 10, 2024 at 03:12:36PM -0700, Dan Williams wrote:
> > I had asked Fabio to take a look at whether it made sense to continue
> > with the concept of ras_userspace_consumers() especially since it seems
> > limited to the EXTLOG case.
> > 
> > In general I am finding that between OS Native and Firmware First error
> > reporting the logging approaches are inconsistent.
> > 
> > As far I can see rasdaemon would not even notice is the "daemon_active"
> > debugfs file went away [1],
> 
> It tells the kernel that it is consuming the error info from the
> tracepoints.

Yes, my point though was that if it got deleted I doubt anyone would
notice. rasdaemon explicitly does not check the return from
open("daemon_active").

I am also curious about the history here. This "daemon_active" scheme is
an awkward way to detect that something is consuming the tracepoint. It
was added on v4.0, but Steven had added "tracepoint_enabled()" back in
v3.17:

7c65bbc7dcfa tracing: Add trace_<tracepoint>_enabled() function

So even if non-rasdaemon userspace was watching the extlog tracepoints
they would not fire because ras_userspace_consumers() prevents it.

I am finding it difficult to see why ras_userspace_consumers() needs to
continue to be maintained.

> > and it should be the case that the tracepoints always fire whether
> > daemon_active is open or not.
> >
> > So I was expecting this removal to be a conversation starter on the
> > wider topic of error reporting consistency.
> 
> Yeah, and then they'll come and say: ew, we're getting error duplicates
> - once logged in dmesg and once through the tracepoints.

That would be odd since there is no ras_userspace_consumers() in the
ACPI GHES path, so it is already the case that you can get duplicate
error information depending on which path triggers the error.

Tracepoints are individually configurable. 

> So just like with the other thread, we have to figure out what our
> scheme will be wrt hw error logging, agree on it and then make it
> consistent.

From my perspective I want alignement between "firmware first" and "OS
Native" events and I think any movement away from kernel log messages as
a hardware error mechanism towards tracepoints is a good thing.

Recall that tracepoints can also be configured to emit to the kernel
log, so that might be a way to keep legacy kernel log message parsing
environments happy.

> Do we want to have both? Should it be configurable? Probably...

Would be great to hear from folks that have a reasons for kernel log
message error reporting to continue.

> Anything else...?

Uniformity of error response to "fatal" events, but that is mainly a
PCIe error handling concern not  CPU errors.

