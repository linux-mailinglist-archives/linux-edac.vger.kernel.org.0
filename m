Return-Path: <linux-edac+bounces-1338-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9536912CD5
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014E91C23816
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2D15FD1B;
	Fri, 21 Jun 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tnw6bM7N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5A13D521;
	Fri, 21 Jun 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992795; cv=fail; b=QeDvEypFGwb5k4Y6vQeVwRxHK5wOATsTRrFnSAvdO0VWbYQYondJz2JWdOlQcS4dPL66Liw9bov9SONyJNjtNLb/eZpCloGuIrVR1KUqmt2DyolrpgMyORf9we8u8g7RdyvHaU3JqVf3r82+yGeZfMVYeC8ZFOiTFC1rJTI+mNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992795; c=relaxed/simple;
	bh=gwxfVzuXwIzsAitT2FKb5pw2WkGN2+ydwR7mtdnWVmc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nG3GYtd0NZ/LboEeMgTE48vRV2OB9KONfWIj/vAB3/e9rPziNbFOVy3to82QGGQpfBb1UHFBpHZ3BgWMtN7b6nioK27bhNlI4+2CFFxbahc3/xn28JCT5El1qECR001wyX/jxMTxFW9BcXSgxvu9S1iXbsj8EMnRrnKAUr4MTlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tnw6bM7N; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718992793; x=1750528793;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gwxfVzuXwIzsAitT2FKb5pw2WkGN2+ydwR7mtdnWVmc=;
  b=Tnw6bM7NNYKDcFcjba3P8Imt1C8c5p9YQp3WMz05ZZd5b4cA5fEOAGW4
   GSejY6IzGLdxCUcLnNc2heCsIqL4EdilF2dQtp8ljQuYw7/621idc5Yd6
   EPJMV7j4JkByDeo4tNrAtSHfdMmmA4hP2g4DdCDN1p6bO3mAkGn3Bxhz1
   TuCZf6TQt4f11UdQmeEqlkAfXioCobIlP3IpreCrCOh7jKIWgieUA3NB5
   3eVGMqHy2ekUrnvbKqmmHEXjGDDSd7sQLi7z519qc6qGi0pUV5N/7Zytw
   eZ0umnEMk1f8sqQO0GSbS4gf+Ap00LI0XFLcK76HWDCIjhBTJVcZByyeC
   A==;
X-CSE-ConnectionGUID: JUwBgLQiSPmatmwIgEiXdA==
X-CSE-MsgGUID: U8znblecSSm37BUmdHFSNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="33497707"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="33497707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 10:59:53 -0700
X-CSE-ConnectionGUID: ldddngJoRTu+7E9UVJoutQ==
X-CSE-MsgGUID: PIwp18MWSDOYcp39Y27JQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47579878"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 10:59:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 10:59:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 10:59:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 10:59:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDcPysyL1CYBHGzKL7gZoVWRN2GUQTzFXo88vHyUb8P6pNQKDXUqGLQzpPV6vQTf4bNU3t2AIlPZtpRwqX/TlVYR+YUfupHiUsENHXM/W/e3zGYrrFV3Pd3rtRoJdejQ4BfypglJvizu6lSLZlsEpmfx0ZzjrfH+Bs49vzMpzP+Z0I6TG2DThyshC5HEW1oE/QU+H7a4Bb8BHVUsEyJjx0A5DUHp8xJ/92OSBV1ar63V6EdtCEcgvJy767cGTAzbzmcB0c/bZ91fccUw33GcL5FTdjzJzr/4bG60hwvfRlQRny1CC1jU7mKckOO7tXy0B+sQWCMj3Yu3LJP/rgXM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wevQysr0nHN4aWSQUBiGku5yOthrKoXFko6oqsVsxhg=;
 b=bLRtCD8JEJ/h+9LPVYrbqXHS6e9Y5xXEOsGnieeZpP4FCL/KmjJ86+YRGpk4ybSPDiGaErR3tiWQAdS2ahx7cI9QA0Enw65aW3A9IP3iMpz2rQY/Rb8PwxGLimZy9+47D3y5+fWO1j5jnWwU81I27+PmgXfjD3eaCV9kfWA6EiL6z4VyQyI3OUnE9izT7qh3x8yecnOftRr140cBgmkRgjbD2tTkrUFdgyBmyUTu2iom1yNjM54lxcSb7OOSffwRXdX9oDXVTG8+MIk+7Kn/YQaugnoyjrgFEaPWFA8ift+uj8cBeb7qNVfJuZbYPXxfN9s7GrF7emR/fz47dfXZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8374.namprd11.prod.outlook.com (2603:10b6:806:385::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 17:59:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 17:59:49 +0000
Date: Fri, 21 Jun 2024 10:59:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiyang Ruan
	<ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240620180239.00004d41@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: cc749220-cdfc-41b4-fffa-08dc921bf18f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/OZvCs8cyTlsSiOQQi6AA9F09Vm5tLQthh9e1JN+NndFBANEYEaB0tfMxWa/?=
 =?us-ascii?Q?79itXqaJmv2UJoPe/AHGET78TtXmDVSGGWxoCFq/UE6G0HrhY8bfIFGSWxOz?=
 =?us-ascii?Q?ehEoaiLjBVZ5AbB+TAJFIz6f236t9ewI33uyZ3MvL653Hgy9ssB4nQVBvuMI?=
 =?us-ascii?Q?BXjEx9PxxjN0CDiHq3YlR78ttayKwGwClDwNdgWPX8id2oHsMOl7FCCpUZ0N?=
 =?us-ascii?Q?zEw8Su3/yu5J0/B2i1/HR7uo+aWXOWeDbhJX/vkL6NCJ6cg6quRfaTWEOKMO?=
 =?us-ascii?Q?52YW6KR5yo9nxb3gDiI1/byE12V/zwKQxtWt/J/Wh4k2dEpo9UQm5iLokG8q?=
 =?us-ascii?Q?M6mGdsm2ccLHph/3UVwgvk4iq0r7kXCVNeGJsLFGlGC0eQtvxlcNbOqcHO7u?=
 =?us-ascii?Q?p6yABgITGg+J7+hJA+Dr7CYcQb2649IwS1Qzrr2MP6n/B/dQy//2C0e1cKJN?=
 =?us-ascii?Q?1vwhURBzls0yV0wEOJWQFR8jBDiFXCVcRRg2D/p9fEEYX+ekXPhGUD+/lsZE?=
 =?us-ascii?Q?pl9596mlxAW2XGJi7OPpbBxcZlnAgux7L8/TF94s6aRbbjbAqN4zuVo6t1kz?=
 =?us-ascii?Q?rx0VMEddH+rn+LyLYZlW38mxmlc8XkKkBC8nrDYl4vPE3Gt31Y2c54vQGPiS?=
 =?us-ascii?Q?yyQWF7dXW6gkRijOT975KuS1JhM2Hkf8ar/w72AiZIAuerF8ibuhepfMZjj9?=
 =?us-ascii?Q?ulL3sSLMR85U62hy9mE4fzJ7Vke6f6iK6Oqlnn9gK1W3mZpLXud2y56F9XC8?=
 =?us-ascii?Q?Za+0/8mxBFb/nJydu2hd+J2qQfeA2N9gWo11IDP05xc/Si9m66Rw7xSxpzQa?=
 =?us-ascii?Q?vinYFozk2+gsWglw8IGnGuMjnqWpN86V35owZkuLYZRD04j8IVtQRNFs11EQ?=
 =?us-ascii?Q?Grb+5AOc6hA7TKXYNPCgqVJZFi/s7sveioiyW5u4FSJ0voAh6WXh7QAbtdP6?=
 =?us-ascii?Q?uwyP3gqXQ968D8stZmT9Cb88dKgjB++3dVCGkGo9ltj6+b32sOgl7MAXCdtT?=
 =?us-ascii?Q?b+11w32Qo1pjR71VVPTbWCaSViYJfN4IcFr2CPSDY6PLq2MBTQHcA7ITB2F0?=
 =?us-ascii?Q?r8PgWdFFwB1PKQsjuhzi75asO6s3XqHwLVjHM1SU7IZEcbSD1vPztlmeeqM1?=
 =?us-ascii?Q?oZ6VnuWL/gLcmSJmen2jCU1aYqiEmsYSvtAxmWL63cJ7vidQOwpPdSQUk0yv?=
 =?us-ascii?Q?2KIg1J4C3MMnh9eGgfU1ZC09BQRcSPmh0/RZ4TUOFkmfpAUodYny04JNw2sk?=
 =?us-ascii?Q?rPa3YkobbW6s2AheUeed?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqc5L/3aO9d5+x423sfEjhe3I7wQD3wmoIBkFygqbd/GfPpDvefarQB8vGxT?=
 =?us-ascii?Q?Wn86UL0mA06kA0a8nQEI/P5ubrUTlQEknjW8wTXo9GMQht/F2UIdPhZBet4l?=
 =?us-ascii?Q?8vf7DthQoir0DAIMWpB0jsyCmz3sZFqi0goqdhHHBI9Jzx6iq+/HZTdY01Pd?=
 =?us-ascii?Q?TjCKcmMKSp6c8tlBHmXaH0vot1ZLouDwXXRR7FvcmriwXAn5KGkzdXkuQ9GO?=
 =?us-ascii?Q?l9nclPgvHlGlL3u4AN9YHNNA/sllCHUF3Z7Fv4MlITrRcVrPSiC2wfmy6siz?=
 =?us-ascii?Q?uBPxlLShnHKyKdDWWPX0dsQG9vnlSVcFDm/hxmRJ5qly0lB2CohXGsS2tuB6?=
 =?us-ascii?Q?xd2tahdPH9Hy5pBC8Fwc/7Ih+c4YU2IgtDZl/EmEs0RV+jQNT9YyaFUNFG+e?=
 =?us-ascii?Q?/4KfxU2KjzXYY1M/6kiAKEe9LRnGmErzM2M/OTEcRXBUqy87rNhuKMWzak7z?=
 =?us-ascii?Q?Tnc2rbEUGwJ17TbAiZ4vxoRSO1p/wpbsnUcUBGeWPYwdbt8eYIfEMQCjl++P?=
 =?us-ascii?Q?Z6znZmhe3swOrof1BEB0xS25bvJALQ5C+SX4yn2556PW93Zyjj7n48aP2AXH?=
 =?us-ascii?Q?m2E5WvZdz0UsCYYx8WJ2QK5hRaRs2KcptN5jzkJOpe+unLE1AqQjXMuJcZFe?=
 =?us-ascii?Q?pDZYkG1StDPcfXe9W9q3okJSxp5cB85C+qFfRU7jLK7Gxnr/JqOsbz0vFLar?=
 =?us-ascii?Q?8+W0SQ3ytNWtlBbUehGNGvhk75QYer4mJJj9pqXRbF24HKB66Enm0CZOxLm5?=
 =?us-ascii?Q?lJXdIUEnm20I/ZInyUhaJwoiOPwCY5l0MNNH2c7sGRfTFxUGqKqRyEjc93bf?=
 =?us-ascii?Q?it79nfVfWdmDxYxzr6eiRVLqU076OawpMqr+h19ulvaa3hHRVI65kGXjbltp?=
 =?us-ascii?Q?H2z9Yh80UEn52Q4yXqiRxBcqvegHZ9kItEY2oaFk2scuQbU2Gp5w1ZvXZYlD?=
 =?us-ascii?Q?Wqbzrsoy9Kme5GVZZsoTmQK4Vdmfq7Ag11DHJ7dn4uOEM033aNRswgoA2J8I?=
 =?us-ascii?Q?YSYKcve/Mg2bNfEZ6nPAUvcKdEX6J2pzbrnMkj70wMZheHQa1+3pbsEygxsp?=
 =?us-ascii?Q?4m50W8wWOZm0axb0BrNhROME2dKPs9sm08rw0l4ZfPWigIYK+GBOUWT2dI2d?=
 =?us-ascii?Q?8TjQyDuHoYgGZsYdTlUuG3CDW1L4bv3P8HdqY0uAhNWvg0Fmso9pvoMAowlR?=
 =?us-ascii?Q?vbMpykHjAp1hl8kHkc36ru8j5q6siO5pk6kyw9dsBiVp2c7ZcYHeS8U1oRfd?=
 =?us-ascii?Q?V4AyCd69XAXAmPiyMhZRwf9L0ZqflFeK9SFNPMr8hf7Hgo73xziMJAuNLwIC?=
 =?us-ascii?Q?otDLNHC/n5a9SmvR5yuLitmqWBqPqPz6Stwew3SdBu6an+wclVpjA9fEBlem?=
 =?us-ascii?Q?y0GmfekAKpnLve1bCYAY3d6eMDo5YEITEGn33Q4+3Z6q1YTOaPcEu0RomxiM?=
 =?us-ascii?Q?DT/DuKho30odYAHh5tmVsRSAcMj8mM9Vlm8HGiwAZdk4W9tUa0ok4ZKAU4Av?=
 =?us-ascii?Q?agXqglsgooO8VXA/EqjAAsGs8dDjTcAwvpEnL2UYwifkJH/q7rXaXatjIt/5?=
 =?us-ascii?Q?seuwezWSm5xtpYVVK79yTqA8hLSd+y9/0FZag3bnsCX9nXJOfbaF/aW4R42O?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc749220-cdfc-41b4-fffa-08dc921bf18f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:59:49.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN93KaI8gKKNcVoxnqbhBN+yT15aawKCrai01foH2617Tmt5cDcGiKRpJM5lJRMrdAVPkby5Qed9loaheHZQcUXnRZsCNjL+MFGtwCbhNzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8374
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 19 Jun 2024 00:53:10 +0800
> Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
> > Background:
> > Since CXL device is a memory device, while CPU consumes a poison page of 
> > CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> > which-First path is configured.  This is the first report.  Then 
> > currently, in FW-First path, the poison event is transferred according 
> > to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
> >  -> CPER -> trace report.  This is the second one.  These two reports  
> > are indicating the same poisoning page, which is the so-called "duplicate
> > report"[1].  And the memory_failure() handling I'm trying to add in
> > OS-First path could also be another duplicate report.
> > 
> > Hope the flow below could make it easier to understand:
> > CPU accesses bad memory on CXL device, then
> >  -> MCE (INT18), *always* report (1)
> >  -> * FW-First (implemented now)
> >       -> CXL device -> FW
> > 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)  
> >     * OS-First (not implemented yet, I'm working on it)
> >       -> CXL device -> MSI
> > 	      -> OS:CXL driver -> memory_failure() (2.b)  
> > so, the (1) and (2.a/b) are duplicated.
> > 
> > (I didn't get response in my reply for [1] while I have to make patch to
> > solve this problem, so please correct me if my understanding is wrong.)
> > 
> > This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> > to check whether the current poison page has been reported (if yes,
> > stop the notifier chain, won't call the following memory_failure()
> > to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> > page already handled(recorded and reported) in (1) or (2), the other one
> > won't duplicate the report.  The record could be clear when
> > cxl_clear_poison() is called.
> > 
> > [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > 
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> So poison can be cleared in a number of ways and a CXL poison clear command
> is unfortunately only one of them.  Some architectures have instructions
> that guarantee to write a whole cacheline and can clear things as well.
> I believe x86 does for starters.

Yes, movdir64b.

> +CC linux-edac and related maintainers / reviewers.
>     linux-mm and hwpoison maintainer.
> 
> So I think this needs a more general solution that encompasses 
> more general cleanup of poison.

I think unless the device has "List Poison" coverage for volatile ranges
that the kernel should not worry about tracking this itself.

Perhaps what is needed is that after successful memory_failure()
handling when the page is known to be offline the device backing the
memory can be notified that it is safe to repair the page and but it
back into service, but I expect that would be comparison of the device's
own poison tracking relative to the notification of successful page
offline.

> 
> Trivial comments inline.
> 
> Jonathan
> 
> 
> > ---
> >  arch/x86/include/asm/mce.h |   1 +
> >  drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/memdev.c  |   6 +-
> >  drivers/cxl/cxlmem.h       |   3 +
> >  4 files changed, 139 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index dfd2e9699bd7..d8109c48e7d9 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -182,6 +182,7 @@ enum mce_notifier_prios {
> >  	MCE_PRIO_NFIT,
> >  	MCE_PRIO_EXTLOG,
> >  	MCE_PRIO_UC,
> > +	MCE_PRIO_CXL,
> >  	MCE_PRIO_EARLY,
> >  	MCE_PRIO_CEC,
> >  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2626f3fff201..0eb3c5401e81 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -4,6 +4,8 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/ktime.h>
> >  #include <linux/mutex.h>
> > +#include <linux/notifier.h>
> > +#include <asm/mce.h>
> >  #include <asm/unaligned.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> > @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  		if (cxlr)
> >  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> >  
> > +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
> > +			return;
> > +
> >  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> >  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> >  						&evt->gen_media);
> > @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> >  
> > +struct cxl_mce_record {
> > +	struct list_head node;
> > +	u64 hpa;
> > +};
> > +LIST_HEAD(cxl_mce_records);
> > +DEFINE_MUTEX(cxl_mce_mutex);
> > +
> > +bool cxl_mce_recorded(u64 hpa)
> > +{
> > +	struct cxl_mce_record *cur, *next, *rec;
> > +	int rc;
> > +
> > +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> 
> guard(mutex)(&cxl_mce_muted);

Agree, _interruptible is really only suitable for user ABI facing locks,
not kernel internal helper functions, but this comment is moot if this
tracking switches to xarray.

> 
> > +	if (rc)
> > +		return false;
> > +
> > +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> > +		if (cur->hpa == hpa) {
> > +			mutex_unlock(&cxl_mce_mutex);
> > +			return true;
> > +		}
> > +	}
> > +
> > +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> > +	rec->hpa = hpa;
> > +	list_add(&cxl_mce_records, &rec->node);
> > +
> > +	mutex_unlock(&cxl_mce_mutex);
> > +
> > +	return false;
> > +}
> > +
> > +void cxl_mce_clear(u64 hpa)
> > +{
> > +	struct cxl_mce_record *cur, *next;
> > +	int rc;
> > +
> > +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> 
> Maybe cond_guard().

cond_guard() was rejected, you meant scoped_cond_guard()? But, then I
think _interruptible is not appropriate here.

