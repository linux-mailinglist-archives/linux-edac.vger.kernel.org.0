Return-Path: <linux-edac+bounces-2827-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1608A04151
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 14:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8493A483E
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050191F12ED;
	Tue,  7 Jan 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZslGEKG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113C1DF25C;
	Tue,  7 Jan 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258269; cv=fail; b=ZJ8sLgGoFjeQnV3X/NA+ya3AvdwW/yg7gwdfp01dS0gSVeEJ8Pid7BKe8HtGkwGQGIGEQ7dBLRZ5YpJ4AcTygqHTP10UBT41ETAiVqVvmGXZt8ff17BIOxTpnGNl8AUujbwmKck7UMyFuVcl0aidAV3EACSwi6g7j5zStISMalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258269; c=relaxed/simple;
	bh=u53/PSSV0oPixVMcBXkk+s0yqurNfH6atErlWd0fLy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F77XLViaGaGLqRvQ1URJvAqjPNwma4tAEfkZ/8vlsUoV3e4/FwzHTgTTXPP9BAqtWpaZ0ZKESFHfS1wt1at9T2fMNgX27YtQOTB8EeVvkI+7p5thCyDXNciaM1Zn/8rTVw5IzMCsZZw/ojzXICYXi2zPVA0+Y9Tk/SEWpZHSl4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZslGEKG; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esgSjynn76ZAdm56Va8/dFx/nHqISvMoHCk0SANM39NmExFnJXPXLBMdLZI656S4Hcg2/YFfApXEOxeDq5e6ZXCJWVzBNtOF0iLlOvNa1O6CZLoQlyoyeLTD2TIHa/4H4SIweHNYMGULeMOrzUmXdM3Boa3lW3PI8vQg/9KkDwNWRtplF+fFB8EfU9NzBHi/DwztHV+PgCSy9a07lYcXWwxYifLGz956k0G6Rdr51xiKJMPU5+S88Wg/6N0CrfX1tBaHHdOTzIEXW/vNtgBIKzfrq66s8a1CuS5WhYA8/mUoOQvGpJdGibU8/XLTCA1jF2DLLxUwuU3QdshtNpKgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr9xoiaWOcj/5apQ1zMKlsFHrzmFv0YtePs2xf6tp5g=;
 b=EOrcTqd+Ku1/Dr80RZ1mRViBzpUF/4FDN1XN9As7LrbOVuv9RcdwKxDF12eSh5+oeG9Wxxprb6coZIgKxobNm4JWDImAc8ydrUww9EWB++2pOoFUQWyZEGluOAFdL3GSI1s5Vuc+h/FAVV5rEKYo8gqUS0qoULMofZ3H21dnPbAXG3NVs7ohzBe5T780d3qjM1UO5KRrR1iP1uIjErtdBigirIficwMt4rNrZhSdx1Ea36GvZvWWOwUFkufxgl8Cs+wCVZkqb7bpKEn5HgWgeUREwBNQfQRkAi5mQmeLUpWth8UWJzt2pWWXPTdzqTrWWiKdAeW33VEagNgfxCXIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr9xoiaWOcj/5apQ1zMKlsFHrzmFv0YtePs2xf6tp5g=;
 b=NZslGEKGsGc12gSJrBlSOWPRlO48+TMh6j2fBbX09/SiVQ06EZQ97rhdE9RpzNtclUkicVTMGttnStoj7eFvbCJFY/EhDdIhZ1iitikNBPKQezzaGJMhBlsqqqgWizamlTs0TN5TouiycyEWFbLIQoLFx4XSE1TPDFq8DGzTRCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 13:57:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 13:57:43 +0000
Message-ID: <03897255-6591-4672-9038-e307e6765010@amd.com>
Date: Tue, 7 Jan 2025 14:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: memory-controllers: Add support for
 Versal NET EDAC
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-edac@vger.kernel.org, git@amd.com
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-5-shubhrajyoti.datta@amd.com>
 <ff7wj4atmh2xgn2pqqr3bxecdkrkgaybsph4crnq7eqyrojqlb@dcwa2hlg3umg>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <ff7wj4atmh2xgn2pqqr3bxecdkrkgaybsph4crnq7eqyrojqlb@dcwa2hlg3umg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0180.eurprd09.prod.outlook.com
 (2603:10a6:800:120::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 465211fb-78ac-4d42-4655-08dd2f234241
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUlwbE1TMG80QzVaejBHU1daRlJOalJrVGdPVFNDMXBIeUs5MytITno1STdv?=
 =?utf-8?B?aGpqZkNLWm4ybGswZHl0dG1sdWZ4R3lmdDY0K0lpVGVaWXJFdGZ0eU51QWRN?=
 =?utf-8?B?TVRYcENzSC9tdlNHMHQ4VlVHdlpCZzlGOE5YRnhZN2tZNmN3c2VoTHg0VFda?=
 =?utf-8?B?MzBFYUh6VzdNbStjUjBIUjdlVDh6WmRoOUZkM3RmNkxFR3VMcDR5cTN0akda?=
 =?utf-8?B?NFQ3WnFFdHl6M1VVM0dXaUtiaERrMms1NDBqeFlHN1l6cTVtZ3N3WExjUXZ5?=
 =?utf-8?B?bDl0UHlXZWNVMUt0dlErS24wcElad0lWOHIzMyt4N0ZaRlRjakNjbWpKRmhw?=
 =?utf-8?B?ZEVWZE9JdnVOdzkyNmh6di9UbTAvZGpoZnd2K2F5WlNYT1JCRjdxdERrYmVn?=
 =?utf-8?B?eEJCNmhzc2pXVGI2WXplV1dHVjFmQ2UzdHhmT1YrR2J2ZWttOFFRbmNPOVZD?=
 =?utf-8?B?TVZpdlRMVlVITUt3b3F5SjVWQTRVM3F3Z3pHdEtmZkpNQlZxRWRNbnBPMC9F?=
 =?utf-8?B?ekZxZHRLeUdqaUtMTnI5NVhvTFJxOENQVGFYTlgxWlFFYTFRT2lWeXNMMW9o?=
 =?utf-8?B?VU9RR1ZhVTBkZ1d2cmZWczhWamZocXhOTE9GM1BObGViZEx1VkRXNXJPSFYz?=
 =?utf-8?B?aklwUFcxNjF5SUE2UkZTR0ZNWFBvL1AvZzV5N3VQVXdyeEZNR3d5Tngwdm81?=
 =?utf-8?B?TzBoVHZCVncycjllTWdrcEhscVlha1l3Z3pXcGhwcitja2ZhaXBNZFc2Ym4w?=
 =?utf-8?B?NkgzZnd5ZlZPOG12Y3laWXpmM1RGMTZ3V0t0cGJ3WjQ2ZDZ5UnducmNkeGRw?=
 =?utf-8?B?aGFYRWUyWkdScUdOL0ozRlRQQnhBZHZMMSt0Yy9rbENFMm5Ea1JLczhHei9l?=
 =?utf-8?B?MnBVWTRHWFNnS3Ryb3RPb2NBTmE1UHRMTDk1cEhqTXo0cDV6bWNVYWxVai8r?=
 =?utf-8?B?NkVpTmR2YmpFak1mZUt4NVBFU2NYNFdWOE9oeDBTSVJHRFJXblpQU1A5RXVy?=
 =?utf-8?B?MWZGOVVJUUdrdzE0a0h5ZGMvcFdxbm1uREdRQjdkaWlaRGRuUGdXa1cvNFBy?=
 =?utf-8?B?b09qeG5ZNS9SbGdvSjZYVlczM1FPbWFBcE1NNHd6Y1ZQZ2libDNSdUQwOVly?=
 =?utf-8?B?UkhaWUNxcmIxdGpSdVo3bDlmR3hGR3Z0QXVpb2hvZjllRUhNdCtLY3VrV1o1?=
 =?utf-8?B?TXEyZmR1VFhSNVJVcGlGQUVMSlV5TUNLYkE5bisvM1hFV3YvdUt4bFJFN09a?=
 =?utf-8?B?UlcrcmMwZm9FVFloV284Q0x5M1JYeThQNjkrY0tMdTNPUzFyMlZscERuYy9Y?=
 =?utf-8?B?MzV4UkZLOUdnVENiM2xlRlIyWFRvY0U0T2xkWUp6cXFzd2g4b083YVlsSXZ5?=
 =?utf-8?B?dXNObk5adHFWclUzdjJDWitCZCt2dG4xQUtPd0V4a0EyeGtzVzh6VUpFT1Jm?=
 =?utf-8?B?dVZJSjFudm9nRlhMVHNleEQwVkpxWkxKZlFnTkx3MVpBTnBVNm82MWRaUzhC?=
 =?utf-8?B?TTEvdkF5OGs5RnJzZkt1cm1hRHZzV3BPVnVLMUZRWXV1Ync0ZDdLaEh2QWZi?=
 =?utf-8?B?MjY5dDE3OTNTbzgyZmlUci90YUVWUTNBc2ZLanR3bDBWTVErWmU1Qi9zUFhN?=
 =?utf-8?B?YVFQNkxidVM4MlBNWG5NMjZJWWkyREJBZHhldUMydmhTSXNvMmNleXBOaHZk?=
 =?utf-8?B?Ulkvak42MjY3QUhKbGhKbmlkZXdZTTQ4ZmRpK3JzMURqTGdqS2RyMk5ycnBo?=
 =?utf-8?B?VUx0YW9MMTdCZzRSSXlqdzV1UXpkYklMd1VnQndsUEN1c2NyY3BXZVdlM1FS?=
 =?utf-8?B?UGFOT2hkN0x2VW1RSjBpYUpncnFDMmllSWMxU0pQc2I4NVo5VWxncWhScVNG?=
 =?utf-8?Q?r//R2RbJFCsCr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjd5d2JrQmQ0K2JKWUtGVzVheUFxMjdzRHJEQkRJTTZzS1RwRTYwK3FacVdx?=
 =?utf-8?B?aXZyeEs5MUlrOE40czlwQXI1K1Jtc0ZUUHlNRXBVeFJjSjM0NDhNWlhQVDgx?=
 =?utf-8?B?OW9aVkhPRUZpRGZYRldNK2dtQWdkSXUxL0dnbTZQYnhxelJpaGQ4RFprSDhj?=
 =?utf-8?B?akp4QXN1TW1qZFRJVHFxSXN2Q2FGZlJqZE1Hc2RKZWNrbTQ5cUhXRW1KVGwr?=
 =?utf-8?B?NmtkNzJhWS8za3lxWmFVWjkzSEsvYy90R1RZWkU4cWZRcFFrQVE5RGNtaG5O?=
 =?utf-8?B?Q3BOVTJRbndMVzVPWEh2NHlwUE1wcFVFMXFkbmorMVQ4M3dtdUZpYW1mT1dm?=
 =?utf-8?B?MWNsVlphUEVIK2VpdDhneGxmeFF5RVQxdFZyQ0twd0ZHeDhMY09tQzQ5aElU?=
 =?utf-8?B?VG95QVdFcE8vUWhaK09pejlsbUlGenMybXJyT24wNXlCYkQ0d0tWSEE5V0lS?=
 =?utf-8?B?U2J3MmhuUlNOMHVnd21KQXFQNEhRMUpLOHNlOWsxUWRjY2o5VFl5QTBHUUlW?=
 =?utf-8?B?Ui8zNWNGeVhoZUY0R2xDT3c3eG5RTFlVYklnVzRPcGRxQzdwYi9PZ2N3UUFo?=
 =?utf-8?B?R0pSbGY2Rjl6dFd6TklKemhtRi9aMHkzNWdXcXR2eHR4WHVmelRqUnl3TXJt?=
 =?utf-8?B?MDV3cVJ4OWdTUTFtSGRMbTkxZmxBMG1GZTQ3dkJZaVRrZVU4V250UVFUTU1S?=
 =?utf-8?B?djhDcnlib3U4ZXdpQTE4L0dZaHVhRnd0YWV1bFFKcVNmV3V1bE40Z2dieGx3?=
 =?utf-8?B?MU84cm84TzJtUWZqS3lHUEZvNnNKNUJDMUlWNklCdXArMGZXREFiVTh2NUlr?=
 =?utf-8?B?SFZNbWszQXpqbVQ3TVdQdkhtbGJRaDhkdjFoQzlYcGJ5clRkbTdRRmx0eXVD?=
 =?utf-8?B?eDFnU3FZQ2RDZTNBRHVyOVdDZlMxYzlZa255TFBxTThvRmNOR3RBYk5NazBS?=
 =?utf-8?B?dUtJYzVIakFzYlRNQUI1R05PTEV2ZGdSVzVOcU9OVncwODZUam9OSm9OOHpJ?=
 =?utf-8?B?UE5DeUQ0QlFHWTZxRklWQUpueU9tYXhWdVlScDJpTVcxT05velVvZ1ZYa2N0?=
 =?utf-8?B?RldKbHZSMXJNRTk5aWZFRDN5bHExb3c5bWt6bUpBS1ZLVHdIZnI2ckpsc0pj?=
 =?utf-8?B?alRNT1BYcVBuQWdMdjRVdEpseVpLUnJNUlZ5bXdBMFdGTnNJTUE4OUt5bHND?=
 =?utf-8?B?QTNmMXEzMC9oanBKb2wycDYxTE5NNFNOT2ZVaGcwVDJydUMwT3d0TUlqaVZq?=
 =?utf-8?B?TFk1TTNsdGI0dkdxL2g4VW1LYy91czBaN0pablhpZ2xKY09UMEpSbXpRNHVn?=
 =?utf-8?B?dE1hVDljTVl1NlRYdWhwTHVmV0ZYNTJLVnhqSStsT1dXWGhkVkxud1M3U0k2?=
 =?utf-8?B?ZitJdGx5RVpCbGFlbS95NDA3SE5ibGYzd3ltTGVoeUdPdFJHUDROc3luWmNM?=
 =?utf-8?B?NkVDY2VWdDd4WVpPMW5jWDJRZ2g0SUhETXAwb0VOQ0tZWlRBTnFBNVp4Y3lY?=
 =?utf-8?B?ZEZpYTlBdjlkVWh1T3p3ckd6a3BkN2w0Q1pwRUFHUHY2WEt4ejdUYVBSRVBV?=
 =?utf-8?B?bVdFMjVLOXRPV0dnVmU2WU5aS2l3NUhnbTdHaFVyNGozWFNGeW9RZG9sMGYy?=
 =?utf-8?B?M0lCTm8rcEJSdmJ4NE9wUUkxRCt1ZlFNNjQ4NnY2UXQ3NjI0RzlycUc1c3d4?=
 =?utf-8?B?ZElCV0ViaXIyZkZQN0Z4SjZsV25TYmpUL3NGSDNwWDlvajUvVTd1SGxrcnJC?=
 =?utf-8?B?SngxeDFVUzF4Rmd5UURGVnpNMk14L282LzdGeUlyOTlNSGMweG9WKzNydjBR?=
 =?utf-8?B?TXl0QVFqcmpBSStURDNKTExCa1dlNUtNUUVURXRsZHV2VmVTRDBsU2ducVho?=
 =?utf-8?B?Y1JaTHd6Z0VPNHZzenlLNHpSV2VCN2lMZmF4bnBCMjBMc1lIZHV3dHhCRUUr?=
 =?utf-8?B?Yk0yTy91SG5vRS93VzJuYlpXWEtCbFFPS3Z1YURTU0pFSGpDa1lJRTBhMHdU?=
 =?utf-8?B?bk1zb1FoUkxUWFZrMWtJdUtRaEpyQzlhbXB6RC9uQUU1bUJXK0FTVEZvNnZu?=
 =?utf-8?B?VVE2dHlETTRwNjhlTGhSZFJ6bWU1d1JzT1dnWG9jVlBxelVXT1ovVUVEWEFB?=
 =?utf-8?Q?re1TG4UmNwcylEVXXnanvUMVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465211fb-78ac-4d42-4655-08dd2f234241
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 13:57:43.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqvUBnJ+I+NCXtVrFkkSuhAPtcpuckcGNjMUASZJ6FqAG+u77ZvkgHZRxlY1hDjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097



On 1/7/25 07:37, Krzysztof Kozlowski wrote:
> On Mon, Jan 06, 2025 at 11:03:57AM +0530, Shubhrajyoti Datta wrote:
>> +description:
>> +  The integrated DDR Memory Controllers (DDRMCs) support both DDR5 and LPDDR5
>> +  compact and extended  memory interfaces. Versal NET DDR memory controller
>> +  has an optional ECC support which correct single bit ECC errors and detect
>> +  double bit ECC errors. It also has support for reporting other errors like
>> +  MMCM (Mixed-Mode Clock Manager) errors and General software errors.
>> +
>> +properties:
>> +  compatible:
>> +    const: amd,versal-net-ddrmc5
> 
> git grep amd,versal-net - 0 results
> 
> Where is your soc?

Actually it should be still branded as xlnx,versal-net to follow the same 
pattern for other drivers.

And likely pattern should be also listed in
Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml

Thanks,
Michal

