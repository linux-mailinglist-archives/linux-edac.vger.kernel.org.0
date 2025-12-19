Return-Path: <linux-edac+bounces-5581-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 598DECD20E1
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 22:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B159304B00A
	for <lists+linux-edac@lfdr.de>; Fri, 19 Dec 2025 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E8273D6D;
	Fri, 19 Dec 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EedPDDqM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6432459DD;
	Fri, 19 Dec 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181069; cv=fail; b=IbqJ2ZxWrB3fwMQkubmWDUAB2XBWJMnj7uR5zgS6LLQPAaQZjv6y8iQBCR7CCF07JOkMl6kMuJe/4zAw2lgThKr5EpDh/rTsuJ5pvWw0mnot4ZH+2qvoC1Itgzqk7xvs73EI/HPCYEt4jMyUezhcbbJPLiTrL+JC8YlioCwA7Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181069; c=relaxed/simple;
	bh=KFYlKcn3ylfYcdGAlt1axuLRqaaEciKXbvYPTUCQGhw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FFnvJcG0SALAehV0YDVsDSww6QR6zEGE6iDTUZSNmqmNqDu0JBjMQ7W88nEC6uMKEdbP7xTK+SAqUHaEpnHPoyPiYQuq61tdKP6UEUyIttTSBBKtT/lOZ+DWtPA9akeHNZ4w5uLG0XRdy4G18BMawUmmgfpUAp5au+uISrWDi8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EedPDDqM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766181067; x=1797717067;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KFYlKcn3ylfYcdGAlt1axuLRqaaEciKXbvYPTUCQGhw=;
  b=EedPDDqM1xQ0uJ4LSI/uxeUzPbxZpl3TZYcMEPJNrCMwYQh7mMHyGMrX
   qJeu3NV1SbnhVGXlMMv4AaI8Qyfymjl06V/1mts3zFzKiqsSemE/cjZtw
   ttMYRullLWASEWIz7lyK4je73ljdm9uEFSZ9v/6lLZN46hJVGgDmAR/91
   +X+LKtlwqTw5Z+TSGn/ovsAMrQ5gcAQ31GGD0A7naWoYpbTJM6eQLZqIL
   UCLq3PFX8v66ls4+XynixHNwyNATYG9acgiV/erlNoGqkkJzJSxODARSP
   H9WNHUfp9o6q08BqnmTYpUqYFu7oMpbbxt1zXRNtuNWJDjdI0T+fhOtlr
   Q==;
X-CSE-ConnectionGUID: 90JFWWMQQyuPpLu5ZiGMRQ==
X-CSE-MsgGUID: d9iKqe3OSN+fRWjAzfA1Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68079615"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68079615"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:51:05 -0800
X-CSE-ConnectionGUID: BBkZG+5BT8qCXUChxQFUPQ==
X-CSE-MsgGUID: 1JkPItuYRFWRNPOaFRFgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198116426"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:51:05 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:51:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 19 Dec 2025 13:51:03 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 19 Dec 2025 13:51:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cisrdsq9YSfLOewHRcq51qPeelk7BllhZKbnusFt4Cn0seGrw1sOTe/uoW0XW1jO6VGKCEoQFkq04jQG+31nZ3nAh2GXNqBkyXT07CgUS2RM1qOTbBO2HRUAcRAy/UaUoXtwOfby3YvCyb0N3c5peutajpupth4GRhekv7/fxT6WjmpvoaSVew4FnMQ6wNIO87kzP1koxxEypolOU/A+6XzWo4MYc6WpyxPIKV3zj3IGypIcz1L3i9/lqvoH2KR60+0/724YikseSiw31LimcSPeX9WZZYCrlWHHG9t4r4TETjgWRMWOh/DiOLgA+g8QEWF1OnYZtz+UXxVrpqLOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpUy5Sk7324aE+1Vetbr5PcK/TdyhntBjdnTbTCpT2E=;
 b=tz/VC1+oWLIK1CM1up2LybUNsRC8jjDUuzn9itUevs7bwTV4cXAK0sxpKpryHkQQl2QoEV2l4aai6fxdmU17eVuGTU6Bw5iCYWqKb3JYVGG8kyZLRQSBxPwYyozLEfPqWuWon9eMnou9IimKavoVf2JSahlT1smGXgp0R8Ytj9b5ioFLwT76YGP91L56ROq/SK/MX+frD5FNPftpj4q5xd2VVf96UiH+PcTXviXYEOImw9sAF5t4crVWGrvmN5ZYr58HZorRforRhTF3AgJxznc3eUx/COtoSMTgF79WqnBXF28w5BspPRDPuSotW9ZIlXDcdwleXDKRBmgv9fK8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 21:51:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 21:51:01 +0000
Date: Fri, 19 Dec 2025 13:51:00 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <bp@alien8.de>, <jianfeng.gao@intel.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>
Subject: Re: [PATCH v2 0/2] EDAC: Add two Intel Amston Lake SoCs support
Message-ID: <aUXIxIPrSY_y76Xp@agluck-desk3>
References: <20251124065457.3630949-1-qiuxu.zhuo@intel.com>
 <20251219042956.3232568-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251219042956.3232568-1-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a5ca35-3ecb-456c-5f24-08de3f48b35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LYcbcK7uJ3ca4slq6kAOEc02WDrGL8U7ryAvYPxc+nK71yAs26RH2wgK2WvR?=
 =?us-ascii?Q?0PPnLXvhExsBAtwXTVsPC1RyV7o9zKHLQ6AYrJaFhwjQIuHtawd8o35Kw2sR?=
 =?us-ascii?Q?FI0TaJzShzQ/aSDKUPHZCp8sNyozv7LRxscmFTTejU9U8aHo1XJuD2hCk8h/?=
 =?us-ascii?Q?i3HMUCIusuH6NDd5BlnfeLts6A1r+C4Vcq7/MnlZ2BtEcRgHv6H/+h4s5MaE?=
 =?us-ascii?Q?rkgXuTA6oQibTWuwHZ0vOdpz5LnEwDpArla603SoagN9hbIxcg3bmpzLZMaI?=
 =?us-ascii?Q?eweTK4iukicQS1Ax/Pdqvx2oyFZO2iaF9N5ZHLr3ng9vJvgmH9aVBS8vd8h9?=
 =?us-ascii?Q?So/Z0QlD1Oc47a1lwJyKYAmRqHP1o8ZKvJUSHu5XMDKHeEjCVclnX4qq8n6u?=
 =?us-ascii?Q?QLy/NolKjmds+3wJNYKEXpLsXWQMjQSJsotRPKr6fPiqBb09bbo+VO19JPcf?=
 =?us-ascii?Q?wJEmc0YSY0iKYJ6eTHn1qKCZUp81ghbdjaglaf6ldCt+90zM8FqeJp0XqoZw?=
 =?us-ascii?Q?dovq6+bGc9sC0X4E+bpauKL3izwLwDksgJTVe9g7R8uKXjhmjwAQvkiAVtQY?=
 =?us-ascii?Q?fj25szUmLL+G3xKcvJGuA6UMbK2P/CwgNcjiKoMwQQhNGLw7PfmZ2DfT1Vik?=
 =?us-ascii?Q?2F9Hwc+cl+lVKWQua1Lfd4v20BqkdyHa1lClPbJr7WnDJSBS4NChK7zFfD/b?=
 =?us-ascii?Q?Y+mwIvyOUaV0uCR0js12NiMyxdMkBV8ZOuhw4H34cnAxdfzLlFGAne9n7uQt?=
 =?us-ascii?Q?xaZoVyzduuS7mlyf/Ntj8KsM16Gxclb9VEd+dLkCp+jrK0ceOXxzWDQQkxUr?=
 =?us-ascii?Q?CS9h3RK0vc6Kq2E4jF7sN+eMwrVdhu9q0eVWL6blNJEZRdus9PWJdN7e5650?=
 =?us-ascii?Q?Rea6oP51jXyUSZTAFCLBEPmbWbO00cjGS28UaMV3g1ImF9kboyVtl8Ch0mbb?=
 =?us-ascii?Q?o5MGhijzGiFb1pRw9m43AgYtaNHnJyPyKbwhBv1qUKHrXl8m6g/Cbk4raZAp?=
 =?us-ascii?Q?GS63FGaYJkBYHyM9xUhkfuU5IAlAymDks+ngzOEUWiASpGsgQkYaVK52dyVl?=
 =?us-ascii?Q?LwPnUaxMqnrqwgrsKgXgBDt+zXvl0SuxaFu6fwwwxXQk1K+PkpDS151HYRPk?=
 =?us-ascii?Q?gy7JTg+tgP/6xOzln208Z4W9uJtcFU5yiSc5SxaoDI/fZwU502b0YL4+0lu7?=
 =?us-ascii?Q?7n55kDaSzJTCGR+/RwAbnw55zg2dRtuKA8YZYQO0kL91/FbX1XJBMcjrIgtB?=
 =?us-ascii?Q?D6ECM+imk/cGUgm0QeQ8om9Ecngy527u/0FSr1AiUIYhclg8Z4vZfTgOc9bN?=
 =?us-ascii?Q?t7yCDhNAd9t7hEby+Ujx+79rXtz8AKDboHt/ICN/Ydisym+SflRieQjYUn//?=
 =?us-ascii?Q?V0jyHmrfiWtpPRQAv0g21cMvV1fttd3WK6FZkI7sk+/AqT4bSMmOsveRceIn?=
 =?us-ascii?Q?8pV2rl5AkZSLr2HEV93XLwxUkmsMhwoO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lj8820t29T5eXSHna8e+39M5Evri1L+3gAnIr9YxJtcHQIDdkCHz7kdtsU6?=
 =?us-ascii?Q?Vk62ObUjgdCjoM/pC38F0zwMPKfS0nWQXsqkBnAq5VGQltz6qSiK1TqQNoYJ?=
 =?us-ascii?Q?YnlBvEtVcbql1cAkxF8mx1hXFSuj3rENlytZI4qIqZctLyMYIN9xd+3hqJdY?=
 =?us-ascii?Q?8NBpJrXRq92NdAE3FlC+RXmyL6+XrY3YgE8+RGoenyMhP6BwntsOId7H7N7p?=
 =?us-ascii?Q?A2F2Nd/8iShq/2mKmp877XMyhiLBOUYSBVR/eJj4+9+Wv1QBozA/eeF1QmqR?=
 =?us-ascii?Q?yR1uQiG4fLdCPGVCKyVaGvcemcOqHZJjSLHoGfFT2S+MixtSxvTcKQTcHU1z?=
 =?us-ascii?Q?W7xluJMcFYJr2/rZRY9oQhKQVazY7FSsGapqgE73iMXPAMH6O42Zrt93/qsd?=
 =?us-ascii?Q?nmkrRVTVIw8uRA9zRNXHLRralRXQ/8Tq+IJf1YR7sHK73sWDcOAZ6M/cGook?=
 =?us-ascii?Q?1m3eDzatTZMaEb4aXcp+JhLr824MdcvV2y5lV8m7fhNVggpfrUmivuPciEoq?=
 =?us-ascii?Q?khLiq0+3r9EIdG3SOU3ofBjpBAOQwmT4eixOwhtqoZ6gVnNl7S5Up5dCLODQ?=
 =?us-ascii?Q?uGxBODDtATm92fUA6Q1GjzBtzLZ/rqnhh6c+B/pr1/2lFknHFONmtFbTSVyb?=
 =?us-ascii?Q?FGVB767qEZJekf8zIYFRONFnaSKvaFbKU9pNc4FAKy0Wk0TByi8I9/+FQAkf?=
 =?us-ascii?Q?AWQRB8XL2LTx8D0TgfFJwqgIOIBMSZ/chZeDAAgJTJEbqziBI+Px1rRyP/et?=
 =?us-ascii?Q?yVmnmutytfs/SjVfrdyHDF3IRJvKZ+56vFYc9uW/X7rNWgSGmUYVLLrhBNyu?=
 =?us-ascii?Q?P+KUH8VU+odhM8O1BCS8p+hJLLmPj94jcD1APBecJRzKpPbGL5uaAxZC52iO?=
 =?us-ascii?Q?UhfBH++RplRURPVd3Qb4SucT1zI8Y7oS1Xwy2Ip3QfoDN0fBTKAqRzH4ccbX?=
 =?us-ascii?Q?044E0DBGJnBh7OWmOuYEPo5dYjXsH7Jo58JaEmLeIe0kxIaiXsi48bOJeXNL?=
 =?us-ascii?Q?C/DoZcbZxRSf7xFT99QzEM3c20rfLAMHyD1O0a2GUQiEWM1DtEYKhb2Te8OA?=
 =?us-ascii?Q?HnZ6xLSfn2h8mAByQUKsRvfK6xZCjaF5KtXQgc9sAZL7LeZMoykQT/aF+NNT?=
 =?us-ascii?Q?AkhUqwuJw0VfpvSivIWgdFsY1Pn0KE/b+e7L1ac4X19g/PlpHkCzjWMNzAEi?=
 =?us-ascii?Q?s2cFvvEShd9No9celUSMvJh6Yokuwh1AJnapCOxe1KrOApLgbakuJgy2cNkp?=
 =?us-ascii?Q?hg7gOtHdnlTByATY0PBx6nhTa0J9Pr7m8EqNDo+vXrcbNopzQK0P8KGBJcVg?=
 =?us-ascii?Q?b0siGifghEmd8RUasfYtFWEFdvINcdeZVdQNwdk8s3Pd/IVn7p9oYZYkoCaa?=
 =?us-ascii?Q?Nzsay1AApjG2f/u5v5xi5ihQSeKQT682pZk+gtqLlSFyWqkc5RxWbBaUhZ2T?=
 =?us-ascii?Q?V0+RPHFZYfIzex5X+SacdDRzHojQ4lPAnVISy0b+AILiex1OUFPs3Nn8+4ZI?=
 =?us-ascii?Q?DNdsmlyKYQyY8vSxXuLuOS67Y7cPV2N4iRTuE6cazN5RkEswQ6+JLeXiNsiI?=
 =?us-ascii?Q?IcNOf0kJmPxsl7H9cm7Yy8eKt7R3eSc+dWzPX3Uw82qal6rVj+i1TwCW0qZT?=
 =?us-ascii?Q?ExlTAdVEpIiG6FD6pEs3N2SU38CWn8vHZbHVRJJeEYarPgqqOXNz0sVNfMEY?=
 =?us-ascii?Q?LzVz4PeODm2pZGY3OlaWdku1oz3U2DN2NAa3vapCR7KoZz5uUvtOBu6xyFKF?=
 =?us-ascii?Q?i8blJ0VepQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a5ca35-3ecb-456c-5f24-08de3f48b35c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 21:51:01.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0otNcREDYwFNL/8HdbFmo1IqP1oSt1IMUnt+Tts+d9TtoLPcNNjFInMtDVcvALR5N9RP+1Qe3gUL0r1Hs4C1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

On Fri, Dec 19, 2025 at 12:29:54PM +0800, Qiuxu Zhuo wrote:
> Changes in v2:
> 
>  - Patch 1: No changes.
>  - Patch 2: Remove local field_get() definition.
> 
> Patch 1: Add IBECC EDAC support for another two Intel Amston Lake SoCs.
> Patch 2: Configure masks of four memory controller registers properly.
> 
> Qiuxu Zhuo (2):
>   EDAC/igen6: Add two Intel Amston Lake SoCs support
>   EDAC/igen6: Make masks of {MCHBAR, TOM, TOUUD, ECC_ERROR_LOG} configurable
> 
>  drivers/edac/igen6_edac.c | 69 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 12 deletions(-)

Applied. Thanks.

-Tony

