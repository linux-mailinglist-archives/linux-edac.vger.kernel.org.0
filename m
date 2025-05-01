Return-Path: <linux-edac+bounces-3799-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB875AA6218
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728571BC4842
	for <lists+linux-edac@lfdr.de>; Thu,  1 May 2025 17:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675220E323;
	Thu,  1 May 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g9dlQwtM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD42AF11;
	Thu,  1 May 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746119288; cv=fail; b=LaFEsy3wFPOv4+Tc6zy8umzvmnrH2iJO3lIkKN+a/I9F90kVUVx6lQJ78lkog3pTt80kU2T+5q2pqsO0woeeZV+F/m9TbLRLjdyGlU+13ElCqDBsSbgZL144C8ocE3kIp9Bn4ZX6fVOTbUU2OB4dOTrqx895ztjAGqGUKyjuCRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746119288; c=relaxed/simple;
	bh=YJkOsf/1jAuqXDbg+GHoIMiAJdwMAHZneCBZm9kPTco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cL6wh7/BHvtpV4nsuF9Vc90CkyxRaNcL5pM01MbGFkd75tF0D8XoSQGZ5n4yX7poC7dr75EXWQ+wQ40WrvKfohrdvr6HbrYHZgxELluxlPRHuej2GQvoOY07CxcPUeuxXwVxbQxq0fry22+lNIUZoX3e/i2i8e+VpU+EabexxVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g9dlQwtM; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZIVs/1R02n0DT9+5qDLOBjS3cyy7X/Yd5A7lRL3CJCTobuc7xcTFvPRF1VIrH+5ApVmz8zc/WyDq1uFqbhpJFgJgMzmIykGVu6SxyjHnkI/wexNImeBoO2ZJjIBnakI9jXnoKdyBbMLRpCDEy5aQIlt8MLOR/s1HuSRYeytVjY3M5T9B/1wfO9foZVvqr9gdG3vF0ECfLFkb/i35UmBcgysbFf3Ut659DcVmmd1ZH0lB4rbCCEHE4cwouvHztJFpxm6+hJdNM7F/Iq7Iex08LuMkcGYvCmSeEnUWstsB+dbfniJOwHWSGK8PFI3VHj01ny7fe6c6zJ518H5TUL15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhO14sZLYZW2QR8mTXZMu9RPuhcu1Ooy29xVR6toYp0=;
 b=eo8x1KcdP9lMJEgnx0zyU02QlWE4JJDMsUo3O3kepjcOTfkAR4sLZffgPbW71NZtI9MLBXChbR0dlbMt2KDK1tvkTJ07cjR43DIJgSrBBGC6kU7jNvXrnxXx5YxcCvI5HrE17/cuY30QElUzvI+jKpQxloVtsOcrGHJiYx60YLXZAU87oFRiQBT6zhIyybPtAQsIwpgaxSrPD3VlVHOopOMQw1o8hw8hi6iAAUDA1Uq/D3FAgAjrCCrKpyVHgyVWMIUMoPSDf0wmaP25IVUm2l04l38P4qJ3WT/nQogb7jkprs8lhBqj6FdajhTEsjWo7mePNVS+iwg3nc2hC3ONMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhO14sZLYZW2QR8mTXZMu9RPuhcu1Ooy29xVR6toYp0=;
 b=g9dlQwtM26pht0PYtkqAm8BYn7nIiRoYQgOOS82PMO7SrpO+dYBwYBuewnYEITxWton21Suj9aIE0oM6Jab95B2RAuPXcgbZ+t/gz9QCOjhGaMW0Wm1wjnSBk9dXzesSqeXz/VvWM4vm9b1mQGCWyEjv3BNKrlu6z2m5giUNc0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 17:08:03 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 17:08:03 +0000
Date: Thu, 1 May 2025 13:07:59 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 07/17] x86/mce: Define BSP-only init
Message-ID: <20250501170759.GA79372@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com>
 <20250417021835.GNaABk-wGduDVt_q41@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417021835.GNaABk-wGduDVt_q41@fat_crate.local>
X-ClientProxiedBy: LV3P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c20163f-9205-4b98-a907-08dd88d2bb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcA3Y+P96emTLc17wMjcf38JcdwbPyhKd3WslFU8360xYqmKKXGaswD/OFBO?=
 =?us-ascii?Q?jzZLL4JN6F8eHJH8vWd2G0Tl1texELNykhIK0WRFyNOun7K967QjkVJiH/LF?=
 =?us-ascii?Q?CEA/dgDWZB2HHyIr5bhGuWuW2B6amCoVcb+uU7WLPaVRIWuYpvRXqS+KQF8o?=
 =?us-ascii?Q?BoLJ5f1XrP6uMvl/s/BLieUjHKJNkNULHg90wKfBPk4zko7b1WWbLHovUAHn?=
 =?us-ascii?Q?ikyfSeeBQs3MwU+6PL7QoEoCyRH4++bJ2XvitgOd6RNvoqQZ6G77f8wEvmhL?=
 =?us-ascii?Q?waR8vcrbiqJpimRdCvAMwFZNNm5xNs85HwDSQcD+KWRIhW/hXobqGhCZYuJJ?=
 =?us-ascii?Q?Tcwve6FiLk2UpNQvQCufCaHMkksQs++jeFJMOTEmSOD5EmO9fDeHq90XknWd?=
 =?us-ascii?Q?fRvlS9VTCrzxtwTlKCsTqlpH1lqpK8pd8ZR0AHvDTBzmq13tOxFyx0TaLBNI?=
 =?us-ascii?Q?ggrCI5XTAjvj8dBldS0JQ/wz5ybW4WkKUnvdyVA/yZLavJ+GdCC4jz4ltgLx?=
 =?us-ascii?Q?7hhYXtuilBUCZIULZ4Qoe1g3aRiSgWzcG/EAOhR2agPGnnKxyAW7jr+kdLbi?=
 =?us-ascii?Q?jy46xA2CsDJq3PWPPXK75PPMl1Nq2CUKPchPj07PieMqOfFyQIULgVWm7EYq?=
 =?us-ascii?Q?yAKcfOG1zHK8po5sjFePb4lGWG2/0V4X0q54IKCASZk1CH5wUkdMqaUkDvTT?=
 =?us-ascii?Q?GRemdcd9Ajoi+djG+Rk1oPgJm7P5L2onNtC5uypNtiYNGDq9LjdDqNpwrTbW?=
 =?us-ascii?Q?kJgJRpk59pkT9653QccmKo1ugtReyqkx+JsD9Dim+JNJRYtqZJ3KvbeGmF+l?=
 =?us-ascii?Q?pBC+vb38gKImkDlYLCiqgBdiNj2TmAcsxYCAMkrKCjw2HhEHG/Wmp+UCgBd5?=
 =?us-ascii?Q?H2Lt3YERMzG6ZMa9/ErPs4B5UANYElC7YjviqAye5AwbsjkXDoP5QqTIjWJY?=
 =?us-ascii?Q?T2gnSreG8bqq5aAFHcfy4bUA9FDv18ysjMRyoBArvmEfDWZdmJ9ch5as3jPS?=
 =?us-ascii?Q?ZJm4G7VMMIyf0as/Pd/7FGXDaIV7rwp3Oc0SFBkhhaQx0OvZdx3yyupS7rHt?=
 =?us-ascii?Q?45KzQ5eP8tAnktH3ZQUu5kk+0ov85tpGGYdiDq+YakH/jUUOmNS2sD0zZmtB?=
 =?us-ascii?Q?MHaT/Qrp7tjtcIC/U5umkA9cMwwcgRDTAAXbqzp4BjcM7If1EcRFTSGvYeeA?=
 =?us-ascii?Q?tekvflE5v+Bpk+CMfpp1CfSwDnC1FIhMnhc0DhxkWG3iexJEQruQBKRXujRQ?=
 =?us-ascii?Q?18cb7u38geDC81ZS5he2Zv08OqR75Gt3tFyejVRq3TsNeGtnrYCpm8mouMT8?=
 =?us-ascii?Q?0/fS3XU89M0JzHOczAoXUqBE9pU3AIgbHxYGVA+wp718CFUYF2L437VIW9dh?=
 =?us-ascii?Q?8ji/sjZoHq3hSYHvnIUNVmFycuX61ZMsLJTypIlzQHlM/aGBNFXgG9ecqJ6A?=
 =?us-ascii?Q?gmwFOQTN1h8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bb/a1upImJejtk3uJhOzoWtOQt1REjqLPNIShgmu1v5NRSGBIQbTqG64krMD?=
 =?us-ascii?Q?YZd8nPKMj/8kmdl9vQX3AeRXHEF65WTGmnS1sqJwc2JC7anU9gJpEmL4rEqJ?=
 =?us-ascii?Q?TNtvkvgiKicrfL1LcaWJtc/1kjvkrLmfLfXOdfUqXonOs9dSAHWWzH0yvo9e?=
 =?us-ascii?Q?b4WfaZWg9lKbxEV9OvqTUBrxWWTyquEkBF3Pc9JU+A14MhYce6qhWX3sapbc?=
 =?us-ascii?Q?T5wMF301uNnU5be4oxexsEnyqCCJkx1Ub+eGFjReaJJyvxvmbV6LHnduMLcZ?=
 =?us-ascii?Q?gjmxFv7jUepsqRm07HyseRZOFQ+HziEkkiYghifF+hAhC/f5qq26wnPksJSU?=
 =?us-ascii?Q?zvAShvXX7+dOVGeVr7/b/6QW72NdztDQNvOSjFosZtwpWtjJh4hGxeg6eeNv?=
 =?us-ascii?Q?RHqUWwAWMMYOdKhFHcOJhSvArL/dm5d+Lm2PQGAe0IByHEbZclua2/wMgFkZ?=
 =?us-ascii?Q?hiFSugTvvbv1pbD1nQDRz0OAJNwCo+r16L7fURPG+xsZw6Bldtftm1oTUXhD?=
 =?us-ascii?Q?6uAWQzTWNvRCj8uOwigjX4LYkojwh9NhDD3rVgbra7gVcsnUls+UOaz4Ou/Y?=
 =?us-ascii?Q?r1Pb2ipQnC0mGiR3h4x6NR96QYpuHjZ9rFO3vmYgxArF+rTT2JYijKe7FxKK?=
 =?us-ascii?Q?sVVhNAgXGaQ/pyf+BPOmZVv5TAoL+EgHwPUa8AV5t4zE+DCTXhMJbxqKeKlT?=
 =?us-ascii?Q?BCRxtBj3qcLfy7Cyx024Micdqs8FCwixZASrH5GWy0o1pnhBe90/FlvdkYOy?=
 =?us-ascii?Q?f9Gdcy1sS9iGu34VO4x4TZfhniFKbtPUt9PADogHa+Ys0aBOumiSVzWUfpgE?=
 =?us-ascii?Q?2FrQfHqctWsc8IthI95B9cibvvJY1JlphcJZbeAZEUQ1pAHoHaXIg5Z5Aw+b?=
 =?us-ascii?Q?Ow3D54z131kfki/mNeaFpmHHyABlUzpccFTFcTbVRFtl2ICnL+JSkZrabMTH?=
 =?us-ascii?Q?71i9GK0Sm0uiEUq8eujBggV5rpiACnFzfV4nLD8QtqQWJ5o/iTbIL8bhX2w7?=
 =?us-ascii?Q?dVxZt3206iObMed5fFrd2ml8tjxLPSbtIEiuhQzF0bqPgB738hijY9SmlV8e?=
 =?us-ascii?Q?AeqyHEV7eIikuUEtB0QLBDW+2KNvdOzo537xxkYvMBfDtZvlAQRUUpqwTfnJ?=
 =?us-ascii?Q?woAzLnsVT7yxmTQaO0pKQo8OrBVjwWe/dRgumjVkp/mN4Bd92KalBNAnm+li?=
 =?us-ascii?Q?oik9mLaRWxwhZAybLRGHEXk1XLj1RSIi7WjNTEdPvBitgqpBK47GpKi1C9t9?=
 =?us-ascii?Q?Ba75sX17jx7VAl7TU9HEOMox3Emo06p4IvhF4rMJ1Akr8YmkyJvI77EucKhL?=
 =?us-ascii?Q?VIU4dsJChoK9l9xs4QyY+MVOcDpeYWOCbzIydy4wvwWO6TTmCc99KFdMp1mm?=
 =?us-ascii?Q?5wEopM6+IqMgsLoq8S2SnE1rFUje0oHyBMjm4UcPASHFgmOVvzasr9WPfl15?=
 =?us-ascii?Q?c7ig2EjHL08DU+d83bsthWmQP+MStPxCzNU+cde3Ly/QyzJ/AyOtbHQLfgAm?=
 =?us-ascii?Q?OehSrqxS8bCwE7CA89lVTHVKqQNMG9wtPJF5KatDZDb7Ee4Bkq/t7e+T85qi?=
 =?us-ascii?Q?krevHOEw7JQnDlQuJlWd/UMrEPeVG+bttl/cwv/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c20163f-9205-4b98-a907-08dd88d2bb9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 17:08:03.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSs9+2mNjDnBUBSEmsq7TRc/48oHVjU5ZjWgK1puTVJ6ciu4Q3ovpgC/6mrLDkirODI8TmWglWq54dhsErUZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

On Thu, Apr 17, 2025 at 04:18:35AM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:02PM +0000, Yazen Ghannam wrote:
> > +/* Called only on the boot CPU. */
> > +void cpu_mca_init(struct cpuinfo_x86 *c)
> 
> I guess mca_bsp_init() or mca_init() or so. Probably former as the name makes
> it perfectly clear and obviates the need for the comment above.
> 
> Because there's also mcheck_cpu_init() which is per-CPU and that's confusion
> waiting to happen.
> 

Okay, will change.

Thanks,
Yazen

