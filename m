Return-Path: <linux-edac+bounces-2673-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D89E7B26
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98214166CBC
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132422C6F1;
	Fri,  6 Dec 2024 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChGizx8+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662722C6C0;
	Fri,  6 Dec 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521274; cv=fail; b=h2WPj3x1XwjTwdPsL0NJN1asgku5dlrKpPBhM61P0EqecjggxeJlyITbyMY0xenGoFr19ROsdFkrfqQt7fY9M79Fe0b5A/tHSQSeqV1mK6jlUQqymbtOGc6AkvRVzmmg/EWeQdbSfOVQaWh+B/diFiKFdjDP/eyqjneahZMB2wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521274; c=relaxed/simple;
	bh=HC2GC9HFShyRZoJEtLrJxpybHN0OqVTFXTp021z8VHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgzPlyECGJRBWfzVwbtd0Q4086a7ykxnKu4EcntZz+Awh+GQOazWOiiTkkcgnUk1I5HTQgAD/1sulzCq99AeuZ4TWGVgEUOAxL+2guwsfZjgpRb9BJ4cn+BQD/HdRwaAF7hfZ+z29gGTinF4ZSxWbLyuYntPoTRN979qQgzjIZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChGizx8+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733521272; x=1765057272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HC2GC9HFShyRZoJEtLrJxpybHN0OqVTFXTp021z8VHc=;
  b=ChGizx8+7gsQd5qIM5JEHB88wBvars7lBtZflOxrHFtcCkA8Z4kMnYM/
   xD1eja/G/0+h50ooql9xuC5Y4Tu+aai720KEFqJw3RA92nCsvo/8y81DS
   LIvynslXCS62oPTLCd89BeEByiRmkvQ70/CodeXhCYrG8LkRYu4fzdoSx
   jg0WtJWRsUPSRpBv4LWGD29cYL66MbPRPTMZ01Y3XRuyKe1y01hqDE7VK
   d9oxeanxjisKh0HIiuUvaM1hZ4KlMSmJoIa5RV+eL/aEcU7Y2ngn//bxM
   yp/U1cRmMoWshJOb03dYYUEpK+61rt2NkHwhGBi0saGgzYyJ7KIVMEf80
   w==;
X-CSE-ConnectionGUID: 6Hjtq/s8R22QeF0WAXxApg==
X-CSE-MsgGUID: SDrZs2UcTXuGwOjKKGQTGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44910959"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="44910959"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 13:41:08 -0800
X-CSE-ConnectionGUID: YoGT/by6TOS5ItRJO5l9sA==
X-CSE-MsgGUID: 8IZaSidNTGGG1lFhp1k4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="99332364"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 13:41:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 13:41:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 13:41:07 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:41:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM8nVppb5VHKHbBsYTd3ubRokZukWadV2nOmi8AQUq8ZNY/Tt0syw9FZRnG09/KZAh8oxU05StsoPA4KAyr3DleTJ3wWKKgHAEJEaitKitbfmiXlH95jscRTjWKCfAp0qcJKT9YUY3neMXcX3p0hGfDOJJDjndjXXkR5HCpqGQTvt9ZVQmLopjUC01jAAAJtKUbfy9hI6yGcOjQERaNK6mLbEQPTYChXBDY+DU/EcDMMfdkZBgKExmGnskEmZctDrz4uvHma5hrQE8OeOSKkw+1iHYylv3R2edO+DIN3WVhLosETs4IQvqBRdfpY3F9BmYWCYxf8IT49hAVw75/Q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFhjHPwKR2uDg6iYD248TFmmYygKR8vNGSjh4m7Jnh8=;
 b=FqZWkiJMSelsQmQJe+FCCaUlupa6K8VZIPEKJqSIMbgUeIypMfYT+RuzsJSFUzRuif4bd0bki1G1dmgQya6FyQJb8YQvYm71YKPROaxNeItyOawWe5xmEoqBw7hdmt/FwtjAH5aG2EYX2tGiUqccHXkltpVbr2fyoKzsBlF+MkqQbfm0vPVzz13AEINTmJ0xB9S6pZErM8RK1GM07fexg5IG6M/OknVVhOCSePJhPctnDMZu+wkFPbVFP9R6esHEyupvtUJ1yfKfeMhriiRallqICewMmPrkovVk0N2M2SIL6NIYWy84BNLTa6JUA4YTmjlAOsqw82R2mN9SJygi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 21:41:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:41:02 +0000
Date: Fri, 6 Dec 2024 13:40:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-edac@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v17 05/18] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <67536f6987656_10a08329480@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20241122180416.1932-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122180416.1932-6-shiju.jose@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:302:1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adcad67-3bd2-4e7d-2046-08dd163eade5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zbLKm6rVnpIk6ZAA//JMX2jGAbSz8E1f3hZrl2Ab35r3UQmrwmd/lF97DsFO?=
 =?us-ascii?Q?G1HjwvesgYKxi6YcfzsuF75ZExvvA2ViwETfm5whbppo3J+mHEEzqFO4E3Ul?=
 =?us-ascii?Q?jzFYIgRolAm3I+1P5Oud79hFqaSap8k0r3CY/qvlRRhQJXv6H3p+vDxVeI5u?=
 =?us-ascii?Q?qkLUGo976kSyzcKbLD/cHk5/1yKjhqNekYCVrdHhqtiHrqkCrRG4tRWONPzZ?=
 =?us-ascii?Q?68PGYfWbyQjvqAa6/Z0n7QBFfL3uxlskQujiINUZuBYnQ/hm7OwBaPrnJZLM?=
 =?us-ascii?Q?RVmpCzZ5clUbp63LMxMU9gKlcDy003fLSciSZqw5EoXV02hvt6Qg/POvBb8p?=
 =?us-ascii?Q?w+Umr3wO91DJd3qDPBnpjQhAcNESQbvdnzd8IujNySc2wb1hGmuLQagyMAwJ?=
 =?us-ascii?Q?KVxPAyW6bHGjaE/RYVJgvz5xKpB80v/a2MtKlJlZ9Ny96fPmtOpXumCJXlWp?=
 =?us-ascii?Q?sTOH75tKjDTPmwb7pCjP/sALUEgzd7P5g1Krfkbyp9ee81Vku/TxkRlZfHeB?=
 =?us-ascii?Q?W88ilx1D8v/V5m1zVxLB0pBww73kpiIO6+Vdm2z3XMpuD03f3qHzhLFseoXc?=
 =?us-ascii?Q?ppbrI/6Y7IB49giyaX+pvzWR6Zb7Cvju2yOXhreS2CwzFJ3XGLRdJr2ZuEyf?=
 =?us-ascii?Q?gKMcvITeHRY/3ETSMxDSEM3n62C7Yada8FKsWixP5pJRMpar1CxwN3h300oz?=
 =?us-ascii?Q?uFZ8PY3QjgXL9dcUtUvbG3Ch8nrNV4zV7ZS5/wiih6PxoXGhLt/N62uVecYj?=
 =?us-ascii?Q?9zDhF7H5QBjoH/HZBpWpeNp9/wCGkWvdvRAev/Cqva41hvieq9glHibZtAty?=
 =?us-ascii?Q?9vHu/8Lckpz/m1iaLCXBKJWVSAQyHiOhTefqyDb5P8f9iJmWuFjwtRvvu5sA?=
 =?us-ascii?Q?yo+rAJspOu4Fd5rX/CdYRsKzwdLKWkz0o/6yS5GS6Kt9P0cmnia49s65ev4x?=
 =?us-ascii?Q?DD6e+iZAo4sl68zKnrBWyCwUMd94avrgq+ASI1kFdZpIe5fBOGdsbMeQSG59?=
 =?us-ascii?Q?cvwcnNTxu6uwGaP9NpmqWPxyVQ1EPlmMzViKDQpYQHhL50K0ZPhJQ+cw7q3a?=
 =?us-ascii?Q?xLrZZ4YcFNa/MjM+jg7zCf8d18sqaUW6mHxEJD0Pnl1R/sJwQiK49edxk0Rc?=
 =?us-ascii?Q?36JXCMxHcRTTg+pSRC+MptqimxKqqIAELLYTzBpGAKb0/nUEbHolXJZAhIQV?=
 =?us-ascii?Q?VXJuHzqz4LLn0AdcqnGVG8njQr3dSRUqlpeIKRlPOWC3D6ujNKWKRggfmUNV?=
 =?us-ascii?Q?fnmHJJjrn3Bk5TDKdb+vnypR+xuvolaFtiWwuY5XtORWkCxUZQTVOIG4XCkX?=
 =?us-ascii?Q?HaQvsD9YWZumpn43iAzIiWQ85oAxPHjREZddnysNDiuNMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmaDf/DxUk6sR+9rD88Y9mS5VzHP0wH6XLFfmo+SF1vSmF0PByqJMk43UAAA?=
 =?us-ascii?Q?YvTg4r20mIy7aC11IqRiLuIEIUXPMrfEoD1UWU1ZQ1LyYXGXwO1lBp2hyTSi?=
 =?us-ascii?Q?oijvGvzNyaZ7Lb+Dsj4cpvymrXfikT1kQOCaLv6GkYdnYBb+HrlXlUxZVCcs?=
 =?us-ascii?Q?SUve1bI3er7TmAqJJ4/Wu+EvceuModer8uo7UzN9ompECWN33w0Za67gPGWX?=
 =?us-ascii?Q?c7AH0vH6Ta3zlKr2GypcKhXzp1NmfmIqbOXS5oDiHtMx2h/NBbechHYNFt9g?=
 =?us-ascii?Q?ckVGfE/F9gRUvYHPpjdxwIaL8toNQYDD6Ygd1Xy4EZbfRkVPZFUl9evdA26z?=
 =?us-ascii?Q?0t3m63wAno2rDioUk0fFVsDPHJmm/oxYDKcYJbKFtdA9diDRgLUbMCCt/wtG?=
 =?us-ascii?Q?GLLZtDPF4C2OQtQxjcjQmrHjRqNAOT7DtMu1IyFAvcjhSy12eJFZ226CE/GC?=
 =?us-ascii?Q?ZPMy/3Fm6vL1xCQxEAGWBDfm139jlU9PgT9LfGxK9A3k4vl5PDRF/m4ID1vo?=
 =?us-ascii?Q?0Ctg0u3VOMEp9Gcuf+zAW22YujojV6T0nglEH1F3N+XwHgpKnEgSjrzN108o?=
 =?us-ascii?Q?7xnVba7Q2kYXhkHgGdQ9UZZSc+jBh3cHC9ONPxcJRATBtXjPgqimDGPY4hih?=
 =?us-ascii?Q?NBAm0WVvxC1zShNG7Pypae2t6daFHV7mOmYBC57i5X6oUgFBzzeRrxDuXpAn?=
 =?us-ascii?Q?SDThBR4VMGyfCzX2PTevnu1Yt6qsZOyPlM00x3kFJCaFHLOF93KWr1FLrE/D?=
 =?us-ascii?Q?32bzDnit4lxy2NbmOGccBCbZOFdzW2tPp28cwi7rAa7JulMBy2kB161chAXh?=
 =?us-ascii?Q?FFvrwrtw4k8Bf+qzZtxx3A3sYNPCGWd0ml/im8MYbto5s4wb9fKdBMEm+IA1?=
 =?us-ascii?Q?ruum8mlnUtQKnVLgRO4XE9LNcUZtqB1g3hRQ4zCXRlR/6m5j4Mw0Q+8+tAiS?=
 =?us-ascii?Q?CBnVDfvDb8sNLk0h8eQL90EabLACvkMfYE7jhxMyxfvUyifLEmyhOK5T/efp?=
 =?us-ascii?Q?pfMrqGiQTOxNM29ud86okLrvKaaCXBw9AKrCpD5od9zMnv01NdkV/hyJUAsA?=
 =?us-ascii?Q?qq1fn2KAD8c+Xsy2aY2ReJ4qionZSYhtrH7HC83Km9ts/djXRzRCOh0y0+8Z?=
 =?us-ascii?Q?PrX/SfZFOmsN68r8gpdvqlfvgZxsJNjuBNZfZD1kUFz1z3g+8P33xh+bDH7I?=
 =?us-ascii?Q?9HhOn3JmD3mggtdI1aZxidoMRZsOuXlPUVRDNYdDqQuNAIPEyHWyL6eVokhs?=
 =?us-ascii?Q?RC+wrXKA1nZ/pae9UXuJU/4cBamWMw3HjODs3GkulKZCbZcXJu4HciJuzsdB?=
 =?us-ascii?Q?CnMNKQMs3A+FNUBDyuS9YcX9ZNlPnvAwLfKLTpkzzL3GazF1746WU4qfh/uA?=
 =?us-ascii?Q?HWAgBbao3Xp4X/KCF1YQrxW+wVlNcS6/seq85UKJ7m9Hmq0A2IfmiRl5Ffhq?=
 =?us-ascii?Q?DCFaec0LV0qHyqDY6rlgWq35OZjvyqw6ed9WGshnFMoDsuTcnQUZtERuANt3?=
 =?us-ascii?Q?hStwGAOxW9fmBjiykDDG4zJZT4M6kiYBMi6rDrxywRf6+Qhg8DUsn/huHyXV?=
 =?us-ascii?Q?17K7Dwg9bThmpEKNFHUU5KLMBvd9gFwnClQJ+fbyKSEJv5RT7b1F70M+fM1w?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adcad67-3bd2-4e7d-2046-08dd163eade5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:41:02.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 544Mun0tInEofsAEsBrgpvqXS7rEyIhpI7XRiBbspgG3fFT2nvj1ik6dKYhRRV8nQCwPvaDRC6eyBM4uIDMU1PfT7tEelCkMdKTlXXjuHIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c      | 179 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  44 +++++++++
>  drivers/cxl/pci.c            |   4 +
>  include/cxl/mailbox.h        |   4 +
>  include/uapi/linux/cxl_mem.h |   1 +
>  5 files changed, 232 insertions(+)

Hi Shiju,

So I commented yesterday on this patch that is also duplicated in Dave's
series have a merge order ordering plan to propose.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 880ac1dba3cc..c5d4c7df2f99 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),

As I mention on the CXL FWCTL alias of this path, for kernel-internal
only usage by definition that means a CXL command id does not need to be
defined.

Setting that aside, the place where CXL EDAC and CXL FWCTL series can
unify is on the definition of the cxl_{get,set}_features() helpers
proposed in this series for kernel-internal submission of CXL FEATURES
commands. I think Dave's series should ingest cxl_{get,set}_features(),
go in first since it does not have cross-subsystem entanglements, and
then you can build reuse that infrastructure to finalize the CXL scrub
implementation.

The missing piece in my mind to make cxl_{get,set}_features() usable
with the CXL FWCTL path is likely to make it be able to support copying
in / out of __user buffers. To me that looks like updating
cxl_internal_send_cmd() to use copy_{to,from}_sockptr() internally so
that it is independent of the kernel vs user buffer concern from CXL
EDAC vs CXL FWCTL callers.

