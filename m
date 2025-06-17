Return-Path: <linux-edac+bounces-4158-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59599ADD73E
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 18:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EB34A3721
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06212F199A;
	Tue, 17 Jun 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xJlB3of5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B312F1993;
	Tue, 17 Jun 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177815; cv=fail; b=lqdEjvjbfs7oywdPwVokzaaaj3vHbnJV6242ETTc8ABcKYNHPGbyr/5qrjT+UyxlnVlQ314tSE9W00YJFrYDtsgtI34KB8hwTPq9BBflsMuunjjI/5w/TS+PXOltHLL7TAfcXLadQtLBNB1AiCgA1SZpZEJ8RVK+QljLtrTjo0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177815; c=relaxed/simple;
	bh=1D4sc1Ea64F2Gy4iw5NdYpHvt0S7iTrm9aLLHaM/8/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8Za/S5SAwaUIZA0sP0F5KMj28pQPT/sidF6COdA0ENkSbLR5bYJdFlr73QhS3GvO/NXyw2RUaPyChZroO3AQSMpRIoKipgWNiNm1vQmiLdvPEwurhUj6H+rvRQ3vedoK7qkhjCZv6z0QYWwReTBURu30P/FRM7F+Elo9XB8N1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJlB3of5; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej1RHQxwNt+f9tT7iBDJMg/0gK78VXiz3nx04TM5NJpeDRPOwViXP42m6w1FLM7a5JALDEukUzIb1phBKkrljs0mgrDDPVfymZNmqjESFzN0s0QjZ4V9knj52+1upoKtML2pa6Nfdx8Sjv06/bqdyrB0waGGeGBbMaUcT+X8/sEFD38M24oiAaWSyDPbcExBo2Dsdv3QNwS9mSSz5ZlkJMSCYNN+DChiHETVY3mpKf2NtsXqh3eque1C+tai+WWaFjbf0Ml93ez33pQHsLGjc97o3t7l2WeW0KLUeXoHz3LRMws1YXmGLDtZ2Y513uRSrzVLMb28hvoVZrcbmvQHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4PHnHZhpJcjFtaxskOAwcpnf5rT+QIi4TJDvKk5P1g=;
 b=VqCVZoDKSdkyQqchl1qil7vhOj4jK+v7430EDm8XP0y6nBmNLIsgvOEgZtHUcU+HBHL2gJ642wgUY6PRaLLyxwch80GPRHO8H0pRS7wY5wmSPVP8rryTbXRH+7P7F7Ta1jeKrJSkYEq60UOB3fuFPHVzbqzT45KE07gxcUGYVH6FeP/fM8ft71BQdLJGDIi+/CKHN80Zf+Rtv8OMrPah+YzSXL5iv60IepZKZibNLw+jvXrl2zIgDfOsYTLYci+f8SMqJWwafMIefxwfaLNrJ0oNX9HGKb4aS+D4aBOxhSHwYGzX2haAT+eGUVivAg1tW6MVnHMgGv66sZSYf6Q3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4PHnHZhpJcjFtaxskOAwcpnf5rT+QIi4TJDvKk5P1g=;
 b=xJlB3of5f5xBlpfQzBYFajdpufzbg+NJWDnoXBnViw53M/a1owX+7jNOHKU5k0CaZtKH8HnAkm2QZacLPN3oOxxN0/5OfyNEWbny8JOxJ2R8Nfzt5VcBui/uZhQ9jHrcnlt1qZoWHUKBvp/57RzrVlsEv+eOl7DyWx9qhb1ayjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CH3PR12MB8458.namprd12.prod.outlook.com (2603:10b6:610:155::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 16:30:11 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 16:30:11 +0000
Message-ID: <04dbfe32-c747-4f5a-abe5-dfe3e1f0fa22@amd.com>
Date: Tue, 17 Jun 2025 11:30:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: linux-edac@vger.kernel.org
Cc: bp@alien8.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20250529205013.403450-1-avadhut.naik@amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250529205013.403450-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CH3PR12MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f145e0-4d98-4f8f-b119-08ddadbc3a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2pFU3V6aElmZ2RrWjc3WWVocU1qcVBkczQ1ekxiL0dkK0t6YWc1Qm1SeGRI?=
 =?utf-8?B?Qm9aTUpjUWdZYndmVjJITktzYndORnp3UE5SdkZUcldzelFNcE0xekdxdXVs?=
 =?utf-8?B?SHh6bUJDNFZ3MGQ4cGQvWEwyU0VmVG0rL0dHZWpLUThLY0RYbC9RMEtVUElZ?=
 =?utf-8?B?NGFHZXRPVDNIT1hpYXUySEIyTU16NDJFc1dlcFpTTHZZaVoxSThINHZjVUJt?=
 =?utf-8?B?RXRRSTd6ZG1EREdXSUNrblBIZERlVWNmWk9rMWZHbjZmOXFKckhwSUxhcXFa?=
 =?utf-8?B?M0p5YTZNcFY2OHk2cENNZU9RNWJlV1FtTWE1ZDZZOVMzeFdoZ1pIM3l0RUUv?=
 =?utf-8?B?KysvaW92WWpZdFJPZ2NmZUdZbnNKeDZadlQrRi9WcCt6SUZJYWw4TEJUM1NS?=
 =?utf-8?B?UjlsbmN0blU3eXhONW9Uc013SFZoWkRNbnN6UE5UUytRYlVhVnZ3VHFWcnZr?=
 =?utf-8?B?ekVKcldvbFdkRGwxKzlHSXNVU3NkVUdZWkRWbmI2Qm9lQVk5dkNkZjdDYjly?=
 =?utf-8?B?WmtTZUtSdVRRUko2VmpEQlRGMnBKV3kwL1BtQzcyVDRWU0lkSjg0YUU2YkRR?=
 =?utf-8?B?VmVFMzcycEF1TWs5ZnZLUjc2bERjOFNoUnk2ZFdyUXpDVzJYbEJFQWJqYXoy?=
 =?utf-8?B?MzhjWjQwTHdHK0tVekwzMURRK0kwMWdib2JYYW1Rc1dna1FPWndOSCtpSS8x?=
 =?utf-8?B?eXh5WjZ1blJaSTBnMHJwUnVTWlVoR2ZTMU9TWjVDd2xoTTBHZlRJSGx1OGpy?=
 =?utf-8?B?MWQ4N1ZIZlVRZ25adEg0cWVNSjNMdEFmYUJqZVorUmZyMjVBZWZEZFVWc3l5?=
 =?utf-8?B?VHhiVGZ5NmlGbUluWEY4VVNQVklvTFI1cWNFdnlVeEcrYlhrWmRCZ2ZOamZY?=
 =?utf-8?B?K3U5dHIrQ3RwUkJwWnlYd1RsVUhMNlJvbEh3Sk0xbGdDVkpQUFowNlBxdWk2?=
 =?utf-8?B?MUVtQ1J4TUtrQ3daWGVIcnd0MGZiVk5KUVBIRVFjUG5ycE8vVU1uenhJOWtN?=
 =?utf-8?B?aHlXK1krUkx0ZjBLeUcrQ01LWFJwbGN6OCtwNVNLcHl4Q1U2Q2N2UGNQL0Z5?=
 =?utf-8?B?MytFVDNhQmZlQjgrSmN0SkVnWWJEY1YvcVRBcWJGN2R5dGZxS3loSkRuWTI1?=
 =?utf-8?B?ckJmT0M3SkNCT21HUXpwSjV1L256QnFTMXV6UTFHNm9rNnVaTDRMNnFoUWl4?=
 =?utf-8?B?QVMyeFRVeVZ1Q3ZQSWhjYmx4RUNzNGNod1A2bEoxWnJhUGRQUEl2cVh0Yll3?=
 =?utf-8?B?bkxRQ1RQMXNPeGJ6eExCVWZUdFp1elVkZjVPVEJsaHR1aFFsdzBmcmRmQ21P?=
 =?utf-8?B?Z3hlcUxxaCtLay9kWUJXUHpWNmpUeVlOZml3NEV0VFdzVzVaYzFGeUVrejBv?=
 =?utf-8?B?WHBwbHM2aTZUNnBHQ0dCTnYzRkRYZCs2RG5RZGlBcHlyQWZpWU1RVm9WYVdL?=
 =?utf-8?B?RC8wVWtLZ3JaeFBOUzlCN3F5S09GKzJRVi85N2t5WjdEOXVLR0lYV2lrQVIx?=
 =?utf-8?B?cDkvZEtnMk1vYktGbWRNUFRETGVWc3VZSitPbWNjQXh5WnE2TTNGbVMzZTNo?=
 =?utf-8?B?UTlaTENHU09OZ3NDQ3RSQU9OdnJOL3drV3lCQ0VYT0RvZURuRDJqaHJxRDBr?=
 =?utf-8?B?U3hEcDFUNmN5ZjZrYmxYOC8zOHA1V09FdFdNQ01MQk1TdWN2RXVVRDZTYzNz?=
 =?utf-8?B?dTVkdk9MSVVBdFFoQ09EQm1IRnRrSmF4RkNrbUFpM040VzBWZW9pR2l6N1ht?=
 =?utf-8?B?SjFBL3hycnJteldiUEN0eko5UXBUaklrclpHdE4vT1ArZWU0RERPcUxLOWs1?=
 =?utf-8?B?dWorU0hmcE1keE0veUx1eFkxZDVGYWZMNU5PVG5sUzdZOVlRNHFQZ3NvWU1j?=
 =?utf-8?B?UFF1THdsMm5COG5RaWtnUDlWa2lYSUFydG5hb1ZISHlkQnd3TTcxNDFnWkIw?=
 =?utf-8?Q?OifFjuqQyM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDE1TzlLQzlPb2FMV2xjeU4zL3lnMzIyWHZac0xxK2plTThXZ1ZacnVXZVhx?=
 =?utf-8?B?OXEzNzZ4NWs5VWtjREcvN09UNDA4RnN5ZUdwd05oVkNWSWJlQVZxMG9sazJl?=
 =?utf-8?B?MnVRMVNETXNTSlpmU1NBNExlVkpyRkx2cjg2amQ1b0IyMTB0ZVVGMi9VbzUv?=
 =?utf-8?B?bTQ2bTJlQTc3QUFsWkQxNDF6QXpOR1JDNVNyODI0alc1NVkvdjQzTk16WUNU?=
 =?utf-8?B?TFNUMkszRjRRRWV6SWtDbDR0TFBDK3ZtaStSV1IwSjdvQTN4eHJtQkVGcS9Z?=
 =?utf-8?B?Y2xUdHhHc3pMU3duQ29lOXB5SklrSjZ5VExxR1pqa2Y5R24xNDFnWGoxbjNm?=
 =?utf-8?B?dVEvanhZKzdybDNSNG42cmVhd2RuYlVUcTRKdlV1NU5wSVFDejRMR3RwYWhE?=
 =?utf-8?B?bXR0RE05UDRRSFFRV2NGZVVONW5kdjd1bUgySldubWh4elQ2aDBJUmtMMHJJ?=
 =?utf-8?B?bkk1Yk5rY3pDSVJjTHBjZkx6djVYN25MT0RnSTlhb0pFUThucjEzK2t5YnFy?=
 =?utf-8?B?UUkvQnNIa3hiMkxYNXNQL09TUDk3Zk9RclhCWTI3aThzWGduZ3d3N0VSdGsr?=
 =?utf-8?B?SXhmUEFzQzlZR3UzeXJuSEpyeTJ2WStTSUwrdnZGOWJteWQyVzI2OW9yTkti?=
 =?utf-8?B?dnFmQXdZQlhsRFBLOUMyNC9Pa1NjYlMyN1hCcjd6RUduaEJWc3REWXRyVkVE?=
 =?utf-8?B?TURaNlhOZXh0STNxOURVV21hNEtralpvWmlFZnFwcUVHNUJmZmxJbDd1Wkxo?=
 =?utf-8?B?d05GSjB2MXlVNmxMYyszZTU5V05uNmVyS1dISUVOc0FYZnA0WnRWT0dGSlpl?=
 =?utf-8?B?Znkxam4yYlNRN3VPR3ZGamxpMjdxNzluZWh4ZGI5L3Nnb1ltbkhtYnI1aTZJ?=
 =?utf-8?B?T0pEU1BpdkZaNWFLT0NTK01QSFJXQ3RrQThYZzJqckFzKzNvYUFjR2NJZi9m?=
 =?utf-8?B?Tm85SVFyb3pXQ0lFamF3KzgzUmpBeHhHd1B4dlpFekJ5VjVDbnBWVmRKQ1dU?=
 =?utf-8?B?YUo5S0JEZU5ZSzhyNGxXT0NSV3FTRXlhUkVkYmV2eFJCbWlwMXpyRG1FbWd0?=
 =?utf-8?B?UUdBZFluNWZSR3ZxV08xWHBiamlBa1ZzYU56RVpUOEpGT1dMaDcrL0VGSWk2?=
 =?utf-8?B?bG9NNVRtSlBBMTFRQ0pqTGd1ZXNMOTNkWmNFUktESVFicU9aVFBTRGRocGdU?=
 =?utf-8?B?L0gxWDA3ZXM4bVV2Y2VJcHEyQ0VLYmN5QkxOQkFHTGZNNFB0cXpZUHVOMmFP?=
 =?utf-8?B?OTlPTFBqOUdVTW5yYTBnSnBTSDRYV2huVWlQYldCM0h5Q1hnSjFGbUNnbWda?=
 =?utf-8?B?ZjJVVzRqNlF6SnV1TTF5UEpqSVgwenlXR041SXQ3KzA4ajZqRWNWTUVBQ1R0?=
 =?utf-8?B?N09qTjNUdWwxWVBxRmpXdW96RXVpU3l4Z01SWVh5VktkNk1qaWllZDVabUht?=
 =?utf-8?B?djZIbkhXUFd6ZWFzNlBpcE1KYXhKcUdZanZ3Zk92WUVsWVFmWmJsRlg1ZjNT?=
 =?utf-8?B?OGc1NXFIQ293amdiVCtBSXpWRzVISkpYWEpmU0pqdGZVdXhzeGFRZk5SZk9N?=
 =?utf-8?B?NnYyY3dpQ1cyRUhzY09rOXFNSE5wbDl0bEdidTRjamFWaTZEc1E5RVN3a1A0?=
 =?utf-8?B?K3lNOU5rb2UweEh5anhzRjVQT2wrOUI1VG5CeFF6OGNDc0pqR1h0Wnl5UWFO?=
 =?utf-8?B?RjdCRTZRRmE4d3REM21ESFVUQ0lHZFJuQ2k2ckNzeXhZUXEzUVE1TXBtenQv?=
 =?utf-8?B?bVhoMTl4MzBTVHcrRUJIOXd5NllWeFh0SzgvaURjMHFDcVBJSWJKWkx6enpB?=
 =?utf-8?B?WHpjcDRpS2hrakR0STlEKy9BL0N2Wnl3SnNUTEZHUnRoTHF4TGRVWS9WSG9L?=
 =?utf-8?B?a0tCOFhJdktrZTh0RDl1NmQ5VnhDQy80azYrWVYvY3JPcnQyVHoyUUJCNTFQ?=
 =?utf-8?B?S1VOY3BUT0ovU0trLzYyUFVJRkpQUk5Pdnh4dG9VbXFPbm10WmI5VldRKzd4?=
 =?utf-8?B?WHR0OEZIUG5zOU1lZnpaRjFXTzFXeTdhYUdyUnkySU9OQXgrb24rWUc0TlBa?=
 =?utf-8?B?ZHlJcHkrNncxTmxxeXdnaks3a0ZXK2NJSytpd0V0L0oraXI3VzEvWHRncnUv?=
 =?utf-8?Q?/WlZAKnVcsjqOMiVnr/lYQD5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f145e0-4d98-4f8f-b119-08ddadbc3a0a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:30:11.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7YhTkEx4A3uxxxJDGjYPLS4YkTRhdn/uDShgCA8/v7etQKo3wy32U+BIIUyTEA40zOQ6EIkW4stsOHvqI/F8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8458

Hi,

On 5/29/2025 15:50, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
> modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
> register associated with it. The amd64_edac module logs DIMM sizes on a
> per-UMC per-CS granularity during init using these two registers.
> 
> Currently, the module primarily considers only the Address Mask register
> for computing DIMM sizes. The Secondary Address Mask register is only
> considered for odd CS. Additionally, if it has been considered, the
> Address Mask register is ignored altogether for that CS. For
> power-of-two DIMMs i.e. DIMMs whose total capacity is a power of two
> (32GB, 64GB, etc.), this is not an issue since only the Address Mask
> register is used.
> 
> For non-power-of-two DIMMs i.e, DIMMs whose total capacity is not a power
> of two (48GB, 96GB, etc.), however, the Secondary Address Mask register
> is used in conjunction with the Address Mask register. However, since the
> module only considers either of the two registers for a CS, the size
> computed by the module is incorrect. The Secondary Address Mask register
> is not considered for even CS, and the Address Mask register is not
> considered for odd CS.
> 
> Introduce a new helper function so that both Address Mask and Secondary
> Address Mask registers are considered, when valid, for computing DIMM
> sizes. Furthermore, also rename some variables for greater clarity.
> 
> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> 1. Avoid unnecessary variable initialization.
> 2. Modify commit message to accurately reflect the changes.
> 3. Move check for non-zero Address Mask register into the new helper.
> 
> Changes in v3:
> 1. Add the missing Closes tag and rearrange tags per tip tree handbook.
> 3. Slightly modify commit message to properly reflect the SOCs that may
> encounter this issue.
> 4. Rebase on top of edac-for-next.
> 
> Changes in v4:
> 1. Rebase on top of edac-for-next.
> 
> Changes in v5:
> 1. Change ordering of variable declarations to reverse fir tree.
> 2. Explicitly state what power-of-two and non-power-of-two DIMMs are in
> the commit message and ensure that the changelog is ignored by patch
> handling tools.
> 3. Rebase on top of edac-for-next.
> 
> Links:
> v1: https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
> v2: https://lore.kernel.org/all/20250415213150.755255-1-avadhut.naik@amd.com/
> v3: https://lore.kernel.org/all/20250416222552.1686475-1-avadhut.naik@amd.com/
> v4: https://lore.kernel.org/all/20250513192221.784445-1-avadhut.naik@amd.com/
> ---
>  drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 90f0eb7cc5b9..35e59abef598 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
>  		cs_mode |= CS_ODD_PRIMARY;
>  
> -	/* Asymmetric dual-rank DIMM support. */
> +	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
> +		cs_mode |= CS_EVEN_SECONDARY;
> +
>  	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
>  		cs_mode |= CS_ODD_SECONDARY;
>  
> @@ -1230,12 +1232,13 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  	return cs_mode;
>  }
>  
> -static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
> -				  int csrow_nr, int dimm)
> +static int calculate_cs_size(u32 mask, unsigned int cs_mode)
>  {
> -	u32 msb, weight, num_zero_bits;
> -	u32 addr_mask_deinterleaved;
> -	int size = 0;
> +	int msb, weight, num_zero_bits;
> +	u32 deinterleaved_mask;
> +
> +	if (!mask)
> +		return 0;
>  
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
> @@ -1248,19 +1251,30 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>  	 * without swapping with the most significant bit. This can be handled
>  	 * by keeping the MSB where it is and ignoring the single zero bit.
>  	 */
> -	msb = fls(addr_mask_orig) - 1;
> -	weight = hweight_long(addr_mask_orig);
> +	msb = fls(mask) - 1;
> +	weight = hweight_long(mask);
>  	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
>  
>  	/* Take the number of zero bits off from the top of the mask. */
> -	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
> +	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
> +	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
> +
> +	return (deinterleaved_mask >> 2) + 1;
> +}
> +
> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
> +				  unsigned int cs_mode, int csrow_nr, int dimm)
> +{
> +	int size;
>  
>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>  
>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
> -	size = (addr_mask_deinterleaved >> 2) + 1;
> +	size = calculate_cs_size(addr_mask, cs_mode);
> +
> +	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
> +	size += calculate_cs_size(addr_mask_sec, cs_mode);
>  
>  	/* Return size in MBs. */
>  	return size >> 10;
> @@ -1269,8 +1283,8 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>  static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
> +	u32 addr_mask = 0, addr_mask_sec = 0;
>  	int cs_mask_nr = csrow_nr;
> -	u32 addr_mask_orig;
>  	int dimm, size = 0;
>  
>  	/* No Chip Selects are enabled. */
> @@ -1308,13 +1322,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	if (!pvt->flags.zn_regs_v2)
>  		cs_mask_nr >>= 1;
>  
> -	/* Asymmetric dual-rank DIMM support. */
> -	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
> -	else
> -		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
> +	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
> +		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
> +
> +	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
> +		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>  
> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
>  }
>  
>  static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
> @@ -3512,9 +3526,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
>  static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
> -	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
> +	u32 addr_mask		= pvt->csels[umc].csmasks[csrow_nr];
> +	u32 addr_mask_sec	= pvt->csels[umc].csmasks_sec[csrow_nr];
>  
> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
>  }
>  
>  static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
> 
> base-commit: 855b5de2e562c07d6cda4deb08d09dc2e0e2b18d

Any further feedback on this?

-- 
Thanks,
Avadhut Naik


