Return-Path: <linux-edac+bounces-2685-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A69EB99B
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 19:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBD28103C
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F6198A02;
	Tue, 10 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eqICGVmc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85223ED41;
	Tue, 10 Dec 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856530; cv=fail; b=SG8GAHgCJW1CpP0scgrXrjw0FgEv57UCZJuZDHdjFBQT2PHA+V/79LJPIlSYKb3OtEACnD458ZyaE7yJ68yx7D0pFVuiIVgJEj4EzTGBI7fc5qZt6z+tJ6PUZ+Ie9hnbGF/H5wJZ+jPNyjb4Pfp44Iku31UfjJXWiGRMr0iSVgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856530; c=relaxed/simple;
	bh=Tzo0I2SOG6iYyfPA/cDVEwx7d97JSnYukvfPaRad9iI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WvptEhGT+xTo/bmM9qkHNPFGTD+dEXIO5BkHi8ghJ1lAJYzkjQ0Jnp/MuNwLWE4+VXFdk6WK8uq7L6eDHGGgPW8inNAF248gxmGeP2rX2WRHZByZPSEDuSvE3isTkqKe+pN+F3pxz4tXaPmVWlTfEB3QcJHFosqqtLYGkKZxcnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eqICGVmc; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im/srUJg6XluT8Ukwo2A4AVEI/A+y5DJpBZrLXsOe3XelwXBAXRpNLZPySSO8zFmvc1Jf88oHmPnLDpW2kvseHXpJrRtxcljo9sf9mokSdAnZkMZN64zvfztkLTN9XhsGAD9Q4kqDtSkpzydQd+8+sXkbAHlhXkME8jw9RIca3XeXDw6s497xcVL3ycp6+8mGOvefigoBPnBrpwT+WelULVpdDzSU1x6Do1udLcw7qevIAoYUZENk/kyIW3y5ckBzvYOse4Pl8llbDtzueYj65giMK0n2Ar2c/KxievhYYdGIaTzzNLiGPn8WJDMI8flwfY1s/RW2uhbe2apWNp4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlQ40X5ev3YAVOtphAULuqRGkOXqdSRFLtuwF5m8by0=;
 b=AGooLYv5fDtDw3kD0FRQrhunCF7fstmeDe8qMSsymjwDN/4eMo4XHbqVuYuPNLRJC0deIK0bstjudYFLc9v/Xm1hwBuVtVnrBgkY81xLvez0NaE3KO5siqxESDopY0Lmvlb7FJTK8bbFZ7Cu/BAUiYnbZbIeiVl1tkQzExKPVDeOf2lJEIcYTo5JAq2s/u0IBenJcHONkrxY/1NUzp49eL3k+kVj6xOj7E5SG0F+aA3BZS5kWDSPjE8KYzPHXP0LsyXolZswC161lPdxWDF/2ZXFGM60N3qeuYzXCwlnh/+GaW6yF7cri2WJdtP+V/OWbaVtatoa5hVxX3MwcyR3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlQ40X5ev3YAVOtphAULuqRGkOXqdSRFLtuwF5m8by0=;
 b=eqICGVmcKjB3UTDX+X5WlKp8QKq9BFQVD2wVIUZJPBh4F5zOdFtfgEzWPCrv6TIQEWRfpBPClApVarDuxs1HOfWexu90Srx0ZUQ9jqHGDIve89ihDiN9X4DxZ9MDSuUaOttnZmH2xHUA+5o5fhZ60J1g+q165Vt01gwMpzYVcFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:48:46 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 18:48:45 +0000
Message-ID: <73601047-ab53-48d2-a819-7ac915f18415@amd.com>
Date: Tue, 10 Dec 2024 12:48:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/amd64: Fix possible module load failure on some UMC
 usage combinations
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20241209215636.2744733-1-avadhut.naik@amd.com>
 <20241210095517.GAZ1gQBcS2BKA30-GO@fat_crate.local>
 <a3990569-ebf8-4c6e-95f7-851312ea823f@amd.com>
 <20241210180452.GLZ1iCxOTAL6eJaaH_@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241210180452.GLZ1iCxOTAL6eJaaH_@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:21::11) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f2724-5c36-4627-6e2c-08dd194b46a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29kSHZhV1Z0SnBhMUlnMW9laDNDa0FEN3crbGgrUkV5NG9BejhHTnYrYkNZ?=
 =?utf-8?B?ZitocjJ6NE5PNmpuRGFaUnR6VjcwcW5qZ2QyNUlOaDF5SDF6Q0RrNjR1SGZZ?=
 =?utf-8?B?UndLdmx5K0lZTWYzbkprQTg1anRIeEluMzhYMkNOWENESGYxdDdzSmN5cEhX?=
 =?utf-8?B?ZWl3SFZ5WEg2K2RmMTNVUEwyZTRKR2Q1QXNjVzI0Y0NLK1owSVlNS2J6UkdD?=
 =?utf-8?B?TXZVYWQ5ZnhQek5CMTFFdXh2eER3UHVyYThVOUlEcUpvZkp4TGFYdHpzbi9a?=
 =?utf-8?B?ZW1LTTcwR1pGM0diWlBpelVDZ0VCa2p6dkFudnV0U2VSbHRpWUJGckJyMnl4?=
 =?utf-8?B?ZUdkT3F2V0Z6YkpxY0M2WHdjR1VZcnZwcmF1M3ZNNzgyVERFbWZwanRnZDlS?=
 =?utf-8?B?Wmx4d2VJZFVsNEdUSC9aSWFYNnZOY2JHNDdTZmw4eCsvemJNUDEzL25DZFNo?=
 =?utf-8?B?VThpRy9hWnlZWmxFOVd3YkJtUWpSSzk2QzB1c1J5VWZ6cE9FS1k2Y0xNUWJq?=
 =?utf-8?B?SFk5V2d5UE9sUFdsVks3Znd5THF6aVVnVWJmUnZReWlQYU90ek5EL3dmdWxn?=
 =?utf-8?B?OXJJSEJQRGV1YjRHcnhJb2tqSHVpRytJUFhka3Y0c2g2Qy9CTjkwTGpmbzAw?=
 =?utf-8?B?VWU0Ty9iSElWWTd0Z1FYc1ZIR2hERmxGZXVzMDM3em5ndmhvbFZyYnROeWFB?=
 =?utf-8?B?cERXR0pUNW02WDVBWWdVUU1OZGl4UFRnaHUxanFxUGlUSTNBRmJ3blAvY3JN?=
 =?utf-8?B?WG94aXdqaXVxOVZWVUF3OWE0bFJRSVpNZ01iVlZ4N2NQVVR2ekZESUJ4UUp3?=
 =?utf-8?B?Y24xeTBPRElqenpMQldnOG9FUmtBZ05IUmRRSlEyN2E2YWduT2pHWTNlTk1Q?=
 =?utf-8?B?SzB6eEJwV2JOdVYzYkFOc0FKT1JxV29MTTkreGkwZVE0bi9yUzl3RCthYU1V?=
 =?utf-8?B?YTVWeGVHcFhtVXJJcjdKSmhyWG5CbzBXYlRacTZ4UWVLUmpmM0ZaQ1FDOHJY?=
 =?utf-8?B?citjTzQ2QWlzb1FmWExPNUNVdzhWMVR3cFlFZ3N1WWR0b1daTVhHQnN3YUxp?=
 =?utf-8?B?cGtCT3k0U3RRNW9kMFVXTnlnMmhuVVZMYjF4SmZPMnlYejNHcVZDQ0FBZERQ?=
 =?utf-8?B?LzVxQ0VVb0x0aUdvQVIvZkoxRlNUWUZBeFE0YkJlSVJsTG8zNURCemU4NHJ4?=
 =?utf-8?B?WFJCeXNsT3VOVkVsZ1lrR1BSZCtyNlVoTC92Wkk1SE92T2ZHRmQwdFllOUN6?=
 =?utf-8?B?QmJHYTFmT0R3YklSSGVKTUF1SlBTby9HbkdKQm5UYldmTUo5a1lpZ2hkZ3dj?=
 =?utf-8?B?Y1FwRUo1dGNNdjdUcGpMVUdFK29MVkR0eDhCTWVpdWc4d0JMOFpKbEdudG1M?=
 =?utf-8?B?Zk9LZ01pWWFaVlZUcDY0UEJJbTZmZ2Z5ckpiQnl1cWZkR1lXWkw4WE9Pd0x1?=
 =?utf-8?B?MEZLQkhVRTNDL0RJTjROZ2RxSVNoOGVqQU1uMWpLTGpqdlNtZStGb1RPcHBL?=
 =?utf-8?B?ZDFtcDdtVDhjOWdhUm4xM0dMbzAybEFLVGoyMjNnL0lLaDd2WjZjNmwyOGhq?=
 =?utf-8?B?SnJNRlRlZDZsYzlTS0tkMHJqVk9pZGExcjVhRTZLYVFlazlDb2VVYWdqZzNZ?=
 =?utf-8?B?SEYxRjh4NDFxaFZ0ZEh1WTNOakc4SElKY05NeUkxdytIVTd6eENrNTFYYnU4?=
 =?utf-8?B?TGV3dUVZNnppdU95Wisrc0dzemJFVlBMSHAyM1J4NGM0VFEyZC9vcXVEUjVZ?=
 =?utf-8?B?ZkZ6WnJXU3ZLS3AveXEwUzZjU21kSlMweUZHb3lmUzRTRms4L0MrWlNWUG1S?=
 =?utf-8?B?NERFUWdVTW1pZEt5Q2tFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmtURjQ5L2s0TUw5TlpMdDZMYjRsSXg2Vmc3ckdpTHNTVWVVcmNNQWxyUEFh?=
 =?utf-8?B?YkpUNnpVbkFYSWQ2TGs2TmZvN3NyK3N4M3VkYzZyUjB1MzlzWkxDREg2MzlX?=
 =?utf-8?B?VnpmR1ZZUmRpUEhhVjI3dUdienVjalhuTkIxd25BNjdkRWhZSjRFSExEbEFy?=
 =?utf-8?B?cDM0QmNHVThoU1hNbWVJYVMyMjRZNE1WLzdHZXhmTThER2ZoK3hFelVXK0l3?=
 =?utf-8?B?dU9kZXhwNkx0SXNYSm5acll3Y0R3VXdIdUQ0VUZCZG04eGZnYzFZUUt6UExO?=
 =?utf-8?B?VVMySC9ITVg4NnVyUVhZQ1FtVmlVNEVWektaZEdUS25rdFlPcldhQ3dwbjN1?=
 =?utf-8?B?ODJhYlFXQWt3b2E0WXNEK0s0K09lWDlsSGxVa2lkQjFnMDdmSXFCSjk0Q0tk?=
 =?utf-8?B?TnpkbEdPNFpLZHhFM1hZZTVRQ1pWUHgybjB3cU5MUStUWmEvZWc5VzN2V1Bx?=
 =?utf-8?B?S2krdGtxTHdKTHY3dUdSR1k3aGVVV3RObno5S0I0SThHMW5UNk1SRktIeG5t?=
 =?utf-8?B?TkRtWFJBbG1YS2RJUUJGMWlvdlJDM1ZPU2g3WHhYOENlL2RyNUhyRjZRcE11?=
 =?utf-8?B?eE92SDFmTGZRN2s5dmxVdFltRXI3azlkWXVjRmh6WmFkaTBwTWpRc2xJaGkz?=
 =?utf-8?B?ei9kWUtJaW1yeHRtaGs2ejZhZ3owWWhBZFNFb0tkVEFwTWltSVNHSG9xdjVH?=
 =?utf-8?B?SzBsQkhmZmc4RnRSS1ZWSlEyb0Z5NHY4bU1WeGp4VUxGYnorQ2grcU5vR1Er?=
 =?utf-8?B?ZHJhYU1nMFl3STNiNmEzMUZzbDdOd0lXZGVTRTVXVk1YSWdnUmNjRmpJcDBL?=
 =?utf-8?B?RkhiZi9QTlJUN2JhZVN6QzBZU3JqcnJPR2RxT1JZUEVBaG9ZU0JZWXlBZUVl?=
 =?utf-8?B?OU80cE45TzhiUG90Y2h6ejdyQVkvUFBSblp2aGZ4ZHl1eWFaSXdTKzIrcFRX?=
 =?utf-8?B?MkhGMzBzNllMMnpEalZkb1ltc056U0IrRDU5cndvdWNUYmJZdHRzd1l5ZFZl?=
 =?utf-8?B?cEhJdzVFeVE5SFZ2c0tsMTB2OTZ4aHlkTW1qMWlUdUhtR2YxR2pKSjR6RW0y?=
 =?utf-8?B?RkdDbENBcGF3V292SnprKyt4Zjd6SWlwb3pMMkEwdS9sY0tzem55REFCUnMy?=
 =?utf-8?B?MlY5Y21ZSlYxSmhDbEllMXZaVUVtWE8yaXR0eFE3YVBreW4wekoyQ09VeEJS?=
 =?utf-8?B?VG5YK2plTGJtMmNkY295cG1YcUxyOTBrTFIrQy9VVnowajljbGRaRUo3MDJp?=
 =?utf-8?B?UndRRW1qVm1BcC9hZGcvTVFPNndpczJnSU5GL3dZYXNBZUZPNFRMc1RzMEJa?=
 =?utf-8?B?Z1YxazdmOW1DRE1nbkZWTlRkR0dMWjN5QnhwcEVZWlljdGtqRllkcWQyZnB0?=
 =?utf-8?B?Q2hIbmZheG1PcWl6RmV6QnlWOGczNFdtVDhJWDZ5UEtRZjRYVVR5WmRJa2JY?=
 =?utf-8?B?VmNFYXlCZ2NJZ0dLTURBOUVJdzJmOG01czFScWtwcnJYenFNdWF5OWhPeXNR?=
 =?utf-8?B?WXE3SUVNcGkvaVdmbVNWOTd0SlpKRFQ3L0pXdHZCd2xIMUdjbHJ1WTFKL0V2?=
 =?utf-8?B?NXNQcm5tZ3pPZ3ppRFhkckV6aTExYkN6LzRTNDRiSDh3OGk2VUQyKzUwV05Y?=
 =?utf-8?B?VFQwREhIUzUzVTFKamFzTEZZVjd3MFhrZVFQeHJ4cTY2WTdRWkt1bFhNMmhB?=
 =?utf-8?B?OTRYOXhaRzRDbDVEWGVob2RyYjVZalpIam5IZWxhaTRkUFBORlIrbUZJZ2Yy?=
 =?utf-8?B?UlVrUXlCMlVPeFljZTBBNWNNU2hCeUVic1duTnBoUDNOeDhCaUlud1FFMjFn?=
 =?utf-8?B?dTduSXdwMXBnL2hjR1RMWVJjbUpIVmlxVWM1cTVDVkZvR0F3SHFIQktmWXlo?=
 =?utf-8?B?TXlaSEozSjRGU3hlcndCZm1HMTA1OWJpSXIzTVkranJENjYvZzFSZUEyVnJF?=
 =?utf-8?B?VlE2YjFXZ1IwY0ZZaGs4TFVjdGd6NjIycTFUUTlaVjZvdmo2NGR2eW1DeDZu?=
 =?utf-8?B?K0M5cmNieDA2TnEyZEYrOCtsMUt1L3lXU3EyVEZEaSs5Y3BMYVpNT2hOVTVN?=
 =?utf-8?B?ZmZ6MjVOMHlnYWdkZ1hUajRlbWFCaHpqQXlMMHpUOVI2dytUcmpQVWlWSkhi?=
 =?utf-8?Q?tEZFD+tw5VXcJJESpxOUd10ZQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f2724-5c36-4627-6e2c-08dd194b46a6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:48:45.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bE0s9EqyPRE0cxZBx8bVrIS1pEw6zJYTimian4eKM7ZcqPyeB1sGqA1kQLfDuHjTA9X5A59PNXunq7y/748bWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053



On 12/10/2024 12:04, Borislav Petkov wrote:
> On Tue, Dec 10, 2024 at 11:32:06AM -0600, Naik, Avadhut wrote:
>> But not so sure about the CC:stable.
>> Quoting from stable-kernel-rules about the patches that are accepted into stable.
>>
>> It must fix a real bug that bothers people (not a, “This could be a problem...” type thing).
>>
>> This has not been reported by anyone yet. IMO, it classifies as
>> "This could be a problem" type issue.
>> Would you agree?
> 
> So if someone populates the last 4 UMCs, he won't have EDAC load on long-term
> kernels. So are you sure about "this could be a problem"?
> 
> Or is it more like a "this is real problem for some configurations" issue?
> 
> IOW, at least "oh, that's not good" issue.
> 
> Or?

Agreed that this is a real problem for some configurations, particularly since
the module wont load, even on long term kernels. Will add stable to Cc and resend.
> 

-- 
Thanks,
Avadhut Naik


