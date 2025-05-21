Return-Path: <linux-edac+bounces-3986-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9386FABFDC4
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31CD57AB61E
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877028F92D;
	Wed, 21 May 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtehJFKm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE31280CE3;
	Wed, 21 May 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858821; cv=fail; b=QfB9W8H4x7Yw6wmuKk7ZZYBeGYNNPlF7Qeou90Uk49n2mpFgxGj2j7rKIvjcl7T3w/wlmYvcWMydLJyCHlqe7lTsXgmvDwwcqW6fW92wYI5LLMiS8tfrFKVgkcd/nYX5kJP1siYa/RO9OLKwll3XL3U7hxXKm/Mrn4u20spq5WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858821; c=relaxed/simple;
	bh=Rla/CJNZreEJ8W91KaSx4WVDnJrRLJFx5Bv1jwqoIIA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LeKlLyeQljvuHnXuMUXtXf8MqhoT98URhYSsTKLQ8uieTIvTXa3f9StwqFRf2hZrQr/o119VA8ZwfcUAzR3bHdZoC58aoGW8mmIGhTXeCvlWv618s2ABgN+8tC5cDguP4d7vT56GwMfAGYOtuOpYtYi9PCiJVtt22VQGxIDJoR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtehJFKm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747858820; x=1779394820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rla/CJNZreEJ8W91KaSx4WVDnJrRLJFx5Bv1jwqoIIA=;
  b=ZtehJFKm2xTRsmFvw6vsHhypsQEtQyAsGPUF/V4z3f/SyihQmadW4aR1
   JdM9dWyer18EaT1Nlhy+5ppuCz5IxRX9qMLgb47gJWYPF+PTYceq0haSr
   9sb6gMj0BqZv59BrRKLmQvp0poFgwEjBOPmDd/6+mqY7aPM11fVtf4yXt
   hdyVFJUrYIm4KPuuQc82G2S0S0Gv/mUxQAL9b/1MLzT3RGaMeUMovzVFQ
   4Ks/G9u/M2nesINuXWE2WS4WvcSEFVeZX5FP4eMxn7mJ+WM5yi0pDFuP/
   One0JJZ7COHQZkNRb9u3GiWEJSwH51soBpvRW6250gtds0oBz4RLiIFIw
   A==;
X-CSE-ConnectionGUID: xOhev4GXRZ2H4tw2/oMXIw==
X-CSE-MsgGUID: xzqpiKNISZaBZmO0nQgfeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="50014083"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="50014083"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:20:19 -0700
X-CSE-ConnectionGUID: 7jCcD6BfSh2twNvZKX2vZQ==
X-CSE-MsgGUID: j4dt0HqQT3aqMqcFCkdCMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140307516"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:20:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:20:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:20:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1gzSuhCbnr83a51uqXQyCWRu7YmtTYHmffBhF42UflwR1caQZPv6CmhEAPob3jBxRmvA5glh6/+CRdYhzoqUs983JA3pqG/xRO+kCmgD0opBhq8lk4BgcwCHi/Ga6CJiv7g8zuWFOfYkZAQiUFJDcoiEpDarz5bgQKSVyFDaDUOYolu1plL51YQiYBqJaQMbvTKdeH+kN/S5qVM2wgdUQy0pCZaen46e97IFamdhtYIJhfk0gIG0WhAIIUG+kq9NHIiX26KBFXoUatch2k1KWsb8YRsHhSoZLn8uem/mZRbgFu4kcSn1PNqK5jDKBUdfv7YgnHcWLxcB0pDvhNvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRiLF3NTkVxXWXlrCWXBsWIEpwTPNM7HkpUW7J0oZig=;
 b=m3oEFhoIibkgRKhVVkLOmTESZ2deTrY6e12Z3xZ/KeS3hHLUOB0AcRt2Q4vXvgn0m+NT6NG1lJ/+Xw8qZi4WqfKjYS57SnP8wUfYfbReOwGlavlGOK8RiiWzmnbVSnoEW5fJROAD6PygZ9PNOPh7Y1K316JC+Pe3LuhyJTGQt8lTkiXb2t9vTUjaUlZOFkJlOTfO8kQ1eiK+HhvQytKA/a0rDNJ1AMpDspz9OXkOkvpzQ6MwuowCodcrQSP8JOKd/BNc9TItbO2ZSBcYe+gN2ty1bwBbGk/OIcB/dVnw6uyjd6pkZwKBWBQLaI9RLaPpH2PR2Ir5h3xacp2fwHxEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 21 May
 2025 20:19:32 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:19:32 +0000
Date: Wed, 21 May 2025 13:19:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v6 0/8] cxl: support CXL memory RAS features
Message-ID: <aC41TzzUDI_ZDlyH@aschofie-mobl2.lan>
References: <20250521124749.817-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521124749.817-1-shiju.jose@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fac2275-4a11-4664-e0fa-08dd98a4cc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8lzz6Y1WKQ6wF/oz3NxzJQNKsWVrkgcGloIvqg49VwSauBtHjAeBouzHLz/x?=
 =?us-ascii?Q?ayhdotzZKBlVf8zoHBB7yUrgZZs0dP4OIQMJigF9tWedU78PZJTqUfzsYSmz?=
 =?us-ascii?Q?StQ61L57+C7wMmtIUIOzyUQ1y/5G66iK5Ls21C0yy4W84EZOnRURLgUBxV9t?=
 =?us-ascii?Q?RI3NpnzdWk6qpIHymMWZ4m8KNDURLeSqQlrtrBgclMXkMKCWKXftKVYFtZpo?=
 =?us-ascii?Q?+ZW802de2qdhoz5GUYDN0ZoBLgnHhAxiEaMuog3s5qZ9YpH2JSaqe1+5RtDn?=
 =?us-ascii?Q?pA26xvy8CvQacKvIoc91/lNvcpb2fblxyFdpkcz3zaao9xH6PQEBNfUlKIbj?=
 =?us-ascii?Q?iriknBu5tILijlSDIqdr4zjZg3QdjkH/2Pg+pinOphuLIh5K05dWUnmEkZo/?=
 =?us-ascii?Q?Tjx6PTXeC1qq4sP/2EQS6gI/rUMD9H4COdAYAqVcIj+tPiKCAliATfXXNNa4?=
 =?us-ascii?Q?xN683Foals6INEH95IDTkhJQVnwLp37u5skqx+EAuAU4VEC62w09l4U41LPo?=
 =?us-ascii?Q?K3ovqJ4pMKwYL1Y53ceTfUVC/dRqvVcdq86KEo3ch00C6ve9yXVVUWbMuNGb?=
 =?us-ascii?Q?U/hssiv/UW/5i8dJeAyhER81P6Jaa8lCEy4sNR10paIVmFvLMyaJg4OjuQv3?=
 =?us-ascii?Q?WL2SGB68YUVGmWb2ne6ZR2pcP8MsvylJsomCL4T4glIrP09jETScxvbjr/lq?=
 =?us-ascii?Q?awQQTaMNgh3Gi0zfva8UtiezFVXm5NePbcvzpGi5ZUiVsdhVom0vHCfqGXNt?=
 =?us-ascii?Q?1PeqsfU47n2VTv/+fg5T8CaM3/rHYmevX6pCLxDJ1jF445ByIMj3YxYtqSDr?=
 =?us-ascii?Q?yomHD1cPUf2U2adL6IS0ul4DRQWjUB4NS8sw7bvTj1WeNsSItOSAptM5lijs?=
 =?us-ascii?Q?K4QWleDoLR/6jXcQQjg4Mg0Ifh3QXeIFtlJ16AA8kT4ya4ypS5vVE6AFMjwT?=
 =?us-ascii?Q?BvIC/hw41ts44ZBq4bXeEWjcrj4/u51fZkqd8yf33ZTloYpdQbi5Kt0lMnG/?=
 =?us-ascii?Q?PcLnCPAKWVnJdebSqWEiF+E6Bxms1XagoB39a3/O+XdlRe0zjR1XERVy8gzS?=
 =?us-ascii?Q?QIuaarXgpZ5f4jw1C8xrJgHW02NFNu8Zuee50WW5P1kw92nr/r+Iu1VoSoFj?=
 =?us-ascii?Q?EmRTS6f6TBDdonOcCyAPZVY96ZEEY+CjroBxgDKfE2nP3PjMeHoG9rsxb1FC?=
 =?us-ascii?Q?lh6P1Uj2tmWOd3dgSBnogT6dXzCowHf/9eUkddbiEyoUagwa1YX1RuRPec4V?=
 =?us-ascii?Q?dXk9Ci3CxA1qu46UFcSNLDFPkJll/sfdqrsMSD0cUyvQyBOu5weiCZAJZWoP?=
 =?us-ascii?Q?nNg5st5XeM+AF0mxjIB03jbC3DIWFcmx1xE2bompp74fvT1uJRD5bhVakFC6?=
 =?us-ascii?Q?IkadqHFKjQQWSmH0neUe0s2JV6eMQqjkGuc1Q8/m+Xb5Ur5x5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8cd/YuZsQlpHou90Kb9fn2JoUYkVW/xpUYj506GGchWLZmL7CwYhhfXl4SL?=
 =?us-ascii?Q?STUq/vKny+Jh+hCKYq8qyH66eGrQUAmzw3tZqJx/L2McjnC66vLX1PFr04N0?=
 =?us-ascii?Q?1CKH+ybdvj0Q0x501LLwHWQv9+++n8xZzhfCu4RuHy6Q4I7Nrgph/V9d7aQ4?=
 =?us-ascii?Q?qNGeo+iCZ4AZ1J77gHeQdd5OpiX0Or6z7+tr1WOpwtw6t2eKF6cYaBi1qs49?=
 =?us-ascii?Q?fHGlP4Lw6HWJJb4eCUqDRNmvByO/2xTCJdGvpgBc43+yS5gJDE0Rn7UoG6Zb?=
 =?us-ascii?Q?2Fk8At+cCS8Xp+g1n3iVDT4XPJgeJAVhq8vuE50ACTLT6F/YC9+gF8zEs21F?=
 =?us-ascii?Q?4PMt9mFd5y76qorWzHDsurq9D5AJZKHc8TO17X3+hQydB6hM5Gfs246cdZ8l?=
 =?us-ascii?Q?Zd2ICgHAkZfUBJMm07+Qp1rVsfqO/u4+/1zvTQe1576HpCJ4OlqQ5sILjX02?=
 =?us-ascii?Q?ndCwsLpSNOYuGr+KPFDE6xlWv6xs7eItBWEr2AYv+A96qnKy1WyquehKXOZx?=
 =?us-ascii?Q?C6tEF6hubDPGHEwrTa0LFuwmByB4Y8zJHTZZAsWAn0tgCODUai+taBI7iQ1W?=
 =?us-ascii?Q?2ba+0pEHM6UiL981M+pzWg2Gfiv862mQMCOZLs2wRa1Jlf803YklKlnVabYu?=
 =?us-ascii?Q?HKvNe65X8kvKZFuzX0BxCiTp2otO17zXTDkgOdvQr5xJr5bFLEWIDP6NYEzP?=
 =?us-ascii?Q?LsKHs588R8vwyEBJ/zOyxf0bsScZR2Xed6IaY755B5flqEML8Ni1rHn4G4lK?=
 =?us-ascii?Q?b+7VciqKq6m5yH+J0Y5A2/CEi8+vd0uQx1z1gzIF5PF+LmJcPvlht/HYd5Gq?=
 =?us-ascii?Q?8FL09KkajBUNkMRdtAxF766sPjKkrDam7YtAW3V9OlQDstLv6tGR74QI2+3r?=
 =?us-ascii?Q?456MrhoAyebtjpQfQJgXao8UuJwKXFM2y6ymGXvUwXxSU0aJq8wYaIeC6A/O?=
 =?us-ascii?Q?SkNZieTHMo912wztMLY3Nxfl3+DEXkAtciM1yBbLEiSKq1wtMfbgcokHc602?=
 =?us-ascii?Q?9+65syL1PsFHf2+vnV3FM3HHmiGjvIWi1zdF32ltE5JGOl1UsKs11Vv571tU?=
 =?us-ascii?Q?fs2+rVmwpwTM6Sh3H87qw7ya9QdgqlQXJq92Ue0X0vlu+/XE00WhxMEhGFnk?=
 =?us-ascii?Q?5Kc30C7PYbE+54n1VI0UcZPEaVCzq/KNiID3LJwbMT31ruV4fdX+BC02TgjJ?=
 =?us-ascii?Q?lc2Q5Kl1mfNf0lDhdIcqzozXo8iQo7gZhpQdbX9ZNvo9tMC4Deszo9IYVFzf?=
 =?us-ascii?Q?rmkqZYW40GezCXljsEPLsFAFcAiF2eYY4TFW/betYZZGzkHnowJRk1JvGhvE?=
 =?us-ascii?Q?zV0JMflm7/5SoGR9URbdpNtfNfTCFf3ki1yCa7crfie/EuQhfRTTZgSR+WHk?=
 =?us-ascii?Q?SrTVshseZPNMVcVTqJD4N3vFA92sPck42xGlTK0bOnD4Sy/Rw4tdTRGl854g?=
 =?us-ascii?Q?v5z4ZJ2gAs8kXKIeVzYjWGm5vnglbqJ240Fj65hZaZjtptyESMITROWbIiIn?=
 =?us-ascii?Q?WYkAHqpp/ZNKTtivtGxZivtgv6ADVhSavmd0t/YnJnRoAmQSzSmA9WdR57Zz?=
 =?us-ascii?Q?wNmilrUegvxn/aw82DJ5RUofB6KRMZ0jARWApDLyHOzP5ErNbqk7+U8KGfb9?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fac2275-4a11-4664-e0fa-08dd98a4cc19
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:19:32.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrzckXuR0YXZr4d4SmyVYinh2YdCiMXQZqCDvXTcIe0A/rBUBvcgGUMdDm9Rv/CSneGYQp0K0NnUztPq9zj122C5HIn2MepokooAyXzFiuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

On Wed, May 21, 2025 at 01:47:38PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Support for CXL memory EDAC features: patrol scrub, ECS, soft-PPR and
> memory sparing.


For the series:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


snip

