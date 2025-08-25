Return-Path: <linux-edac+bounces-4654-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA5B34401
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5007B1301
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17222F6162;
	Mon, 25 Aug 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIpU2D+e"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A36B1F462C;
	Mon, 25 Aug 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132233; cv=fail; b=M8qKJxZGDcrYSQYYrBZUPi0nm1h2dCemsEOVymxlr1i8/WKwHQg7mae1UdQk7CEqCI1WCCXsTTHcNk2p0X02AirrRSqMK9QbabmpW4whIg8QGil3k0JUvWNvAHNjaCGpVWqb06ej7APjqYeW4dq2c2bAQadIJ3pr9vRq6CKYDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132233; c=relaxed/simple;
	bh=v/+cQWxwYPbdRZScJqX/6TqRiZ0wpy68AhD2EUYNv3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPwCeH/M7BqcczXlZQg4xlebPiBw9mih2RlMbzN4XVl08lawSTLaDrbqHQroLuHkffm9O8nuX9ifH10qTEWuFlovz/I4wRJEcbahwaq2HvGuiMeMTpax8L0rUwMzFTeVMNM372iQo4jGRwsTGLvNlKkCzC2ojVWV7iJbb5RVUCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIpU2D+e; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdW68NyDzlGrxqPDCDQj8e3h1YkiaZytHgXy+fpvemgfWQonzDKr9H0hE7dy4+10vWNEGabzrv3qm4pYQr6+5XyLIEcxysBb0YRk4dYiSiKwirOdNnwdg11oD1zmu2BCrMwGsnQ8bwN/NIraWrBoqjIs4E+bsYjFtkEp2tBuOjXhq7388K5TekglnJqxli5WVlk8lbETk4opQ6SyjKmdqtRu9J3q7aXYlUOWQ80RlDNK49wtNcI95VZ3Oyg0AO7R1o5gpfh6oaTKaVgUHKjmUgyMGOi/g4Wl7xTxvJiG5MPtDdtHdv5OWuJ+2dbyZRB98lkLGatT4zwI8dc9TSbnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sDM74lPXSTwQ6ZTmQI0ynNmeISrcLS0toxHmfwJox4=;
 b=QVWIi63fHUrzkWLF6Ki5gocjnC/BAVpksn05MBdeaiJ6h4+FtGaRJIbZ3u32Jf/EndsoHMHDj+0+XTZ9GKemrpQEsiWGro+v41pMqxIaxBbzBrbTGRpRYX4a87YmohSDGpDbj2Nzj11hPJshbRYVEqV8wuvIkP9Rqumfzjza20pSFXpZr+tMtVwPEemi8gAbzi80i+FX7hPnUZXSsWR4nwu3+r3oKNsInGi1RkdX5n5bQbeKM2WBH/b7zOldjVWHoE67dlX2f4lAPO4i3VkvpBspskHN+lDogZUgxwtSiZbXKoyVSWlkqfFQk4ld+zsvhptmSU59nHozZFr5ZusE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sDM74lPXSTwQ6ZTmQI0ynNmeISrcLS0toxHmfwJox4=;
 b=CIpU2D+erAHPEJhKDxiw3OmeflR3Fij+vT2g4Br/GZVGyXITJkshkc79g5sVRthTacsV/8fyG87LJvP8/H2x1Nypn1V934bHlxtYxA9nu/kp75xM8Nduzr2n45g6ea6o9iavozEpNPWQcFhen2tGjL273S1Ixpsh3fK8YrBnHwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 14:30:27 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:30:26 +0000
Message-ID: <ea877d34-1e06-4a0f-b51c-92b706d06c09@amd.com>
Date: Mon, 25 Aug 2025 09:30:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Add support for AMD family 1Ah-based
 newer models
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-2-avadhut.naik@amd.com>
 <20250818212248.GHaKOZqGhfCciWWOcD@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250818212248.GHaKOZqGhfCciWWOcD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5610bf3d-f1cd-4871-afb4-08dde3e3ef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0Q3ZENVa2lML3FKZ2p0YU5sMUZRRkFXRk8zek8vNmhFMGcraVRIRy81SjVv?=
 =?utf-8?B?bTdMZmNoQjczY1hiMUFiaGR6WmxPQXQ2ZVZYODdadjJaMEtiaDdPcjN0RnZ6?=
 =?utf-8?B?TmRHaDJTRHBhQzlMU2NuS3RkT241cVBKTXRZbURsRERIcExxUEVORkVFVHJW?=
 =?utf-8?B?ZnpCcjF6aFpTaFk3cHBKb2ltYStzRlJOSWRkRXpvM3lZN3pjajExMS9NR0Z6?=
 =?utf-8?B?QjB0WnFHbmdIUDJobWRzVGl6R3RSSVZZSkZ6RCtadU5aZjlOeE1OSlJGclUz?=
 =?utf-8?B?MDlFbkV0TVJlUjhFcnpOYXFPTjV0K0hTWUwvSk1KTGpBb0lYa2ZybXFDMkZr?=
 =?utf-8?B?cy9BVDVWY05lc0NDc2xuSnEzSUtua01JQ3VlVEtJdlIwc040NElzR0NyNmk4?=
 =?utf-8?B?dHo4S0Q0cnhlWHZyRlNkVjhJS1EzT0dzcVNVZHdsT2pZcWlNUnlVTjZqWkdO?=
 =?utf-8?B?OExyMzJLUW96Q2g4c2VBS0FCQzFETHF6cUVaSk5FTFU4dittOUNVc1Y0cGh4?=
 =?utf-8?B?blgrSVE5Z3dqSFdXK251bjM4cTR0QU5ZMWVJemFyVzBKYk5kQ2svWTFFUVp5?=
 =?utf-8?B?eHRaL1lQVWdzL0xJZVo2Q0F6V3Znb2VremV6SkNSZ1NjcFAwdDFSNzFsVEFx?=
 =?utf-8?B?Wm5TUm84KzN6QSt3TXNxSFFreVFiMFd3ZUQ0R05pVkxnb2tVZmxXT2w3Nzhw?=
 =?utf-8?B?bjh5VERuTkxHY3FMdlo5SUVEdVVteGc4QXV1eGhzTk5sbXhEejFQdldUckJa?=
 =?utf-8?B?OUxzVmpSeUV2TVRESEt4bTJhWkJjRnFzOEtuM2ZQTzE5dzd1bFhMSFFqNUE0?=
 =?utf-8?B?aGxEYlc4S3ZDbGFoaGVhU2hwdHE4NTkxOFdEYlF4Wm02V1A0QXY4UzlpZHBk?=
 =?utf-8?B?ZExKM3NKVldORTRBZ3B1bVFUdno5bWRVZzVQaFBYWlQxTVgzcjNrNk9VTXVF?=
 =?utf-8?B?RzZlQTNzbWRPVkFvR0x5dFFJTVJVNks3ZkJZbUloQWZRZzVXbFZ0U2RTbEQr?=
 =?utf-8?B?YnpDVHhIRENHa3hYOEZTNjRETVZsZTlkSDAvcEUzOU5Bek9VdHVSdFRuekVS?=
 =?utf-8?B?dVYrY0N2YkJwaU4yODdBVnZ4dWZZOTVuTHQ1eHZacWpxRTF5dDliSlRJdXVy?=
 =?utf-8?B?YWx1eTFDUVNmdGUxL0pQbmxyK2d1RXl0MHEzMS9LOHI4TUcwaWZUakZPai82?=
 =?utf-8?B?ZHV5azRTZGE1MDNxN1dMNFZnTTY5QkVLZHJmMU14ZDFqQko2QnFabkxJUVNp?=
 =?utf-8?B?eFhuY3JYMy9iYnkySkVPSXFUejRpTTRFak9DcWlhcmY3MHVoblhGNG9JZmFQ?=
 =?utf-8?B?Wi8zRzd5SVByTlVmcC9XK1RnM1dEZlYwR0ZRZnBSVmVCVzlFUDVXeEFrdWpn?=
 =?utf-8?B?SkFZSHE2cnNCbU1MdU5Lbk9mMmVVV3ZsMDZSNElRRlhSa0hWMmc0bWpONjhN?=
 =?utf-8?B?aU9wSGNtWmF1MlBVa1BGN1BPaXQ3aEoxKzBIRk9hdzh4bU1TSEMwUzVyN011?=
 =?utf-8?B?T2U2ZXVPM3JtcG5DNEdCU1Q2YnpOMW9YSnovd3hGOHZKbkp6bnpWdnFkbDBh?=
 =?utf-8?B?WGJTbG1TRzcvMG5HWSs4NVlSTEdacGdPV21PZkVCckNGd0I2d3hjUDY3SGZT?=
 =?utf-8?B?MTQwNFI3MHNNWE9mdEFNTUtOUEpNMkxsRHU5MVFNNnRYWFBUN0dRdGRzUzAv?=
 =?utf-8?B?T2UzNlA1QTdZWGlSVEVVTkdybEhmOVZ0dE82eDd2eVBUWEZXRm1sVEtkR3h3?=
 =?utf-8?B?TWFkVFRQTFRoSG9lZG5CUFZkeXRneGVhUHhtdi9GQkFVeXhYZlBaTEkxQ2sz?=
 =?utf-8?B?a2hTSS8zT0VNMDNvNklEc2wwa3FRUCtCQkpiTzhxdUxsQTFSVEpVTzI2aEZG?=
 =?utf-8?B?OFJ2K0dMNGZpNHFBSCtKWkVESU1MZGUrUFQ1WkpPWmJjNmhKUkt0MllDTmRz?=
 =?utf-8?Q?T+ARnSy8wFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUdvZnRnOWVGakVRRzRiSVhyRWU3UkkvTGtIa25FNG9ySERvMWpQSEJOU09h?=
 =?utf-8?B?ekFwRnF4bVdwcUtOZnE1NjBvazR1ZWdmNmxOSWJZN2FiejhraHBHejlZSkFW?=
 =?utf-8?B?SnoxenlpY05HTnZHOXF1RUcvMUdVcmtzOXBhNFpSTHpRaVJWc3hVNjduNFpq?=
 =?utf-8?B?cG9hWDlSbWdhUmwxeUU4NTFSa3VwcnA3NlcvTVlkQVZwRXlrS29KRG9Ldmln?=
 =?utf-8?B?dUQ5dzZuSnBUTUo3TzJIRit0NWx4NTZYQUdNYjZGRXZtd1NJYnJBZmlMam1P?=
 =?utf-8?B?SjVBZ0NFTEZVRHVCc1V2TFltOGgyeCtmMVkzS0E1a3U0NzBMUXhDUFVGVS9z?=
 =?utf-8?B?N2laWHltS0NPbk94cmIyMHE1NlF1aDhqVk13aEpVaXFHWUVwa2ZzWmZDWWVP?=
 =?utf-8?B?YnRBY2hKWFFHNmlBdEdITkd1Tzl1ZHYvd2lud3hLeWIvZnJkblJNNXRqNHpl?=
 =?utf-8?B?ZW1wYTBTR3pyUnVFeXFJbHo5UEVMOXZ5bEpWWk1OK1lhNGxVTmlTbmljYzZJ?=
 =?utf-8?B?Y1BXMHg2YURJZHhSaUd4b2w5VU5sbDJLT0FPMlpucGFQb2dESTJsdFpUdWg4?=
 =?utf-8?B?eUZNN3hXWS9UUEg2RzRsdHRETDBaOHdEZGVTdE9kRlB2WlRQcEgvVi8zbDJj?=
 =?utf-8?B?Sk8xa0VDejJoRXZZanZOMm1Jd2plNEltQ3FiSVJObi9oTkN4UzVXUWo1Um16?=
 =?utf-8?B?RW5lNGJ6cGZWeUxhRzdiSERsdDFYcDN4UlBURmJkamI3VzUxVVNRVWxTeXBM?=
 =?utf-8?B?ZjNJTWQ3eHFtUmViU1pmYWxpcHRqd3p4QitlR0R4MnFXeVlhQ09VelFiVElu?=
 =?utf-8?B?T3Z2NmVOMWo3WDFLWDZ4R1AzR2hkZk82UHdvK2taVFYrQXlTNnZ2VGZBWjQ0?=
 =?utf-8?B?T1dzVm05anR6TktVOXVVNi9YZFAxMGkwOC84bXU5YzlrVFpXSE9XUUJ0Kzc2?=
 =?utf-8?B?WWc5YUtMM09TaFpSSFhGUklnT1Jac3VVMGR4d2NWYysrb1VMS3N3bEtJdE5Y?=
 =?utf-8?B?eGcwcGVHWWJuU3R6RnUrUURIU3g5VW9ZeWNDaEEzcFBwVXFmRDlwdlRqRStU?=
 =?utf-8?B?MXgwakNXM1h2emx6ZnFGVElEQ29SVDl5UVd3cDVVZTlwV2NBSCtyd2xkanV4?=
 =?utf-8?B?QWdVQlZSMGNZckdHVlF0aVVMWXBuM0JxNVdacHNCTGtLZFpoTjF3cHVMZ1NG?=
 =?utf-8?B?THkrOTE0VGJIZFVJOEZGNTdPekt1WExySVQwcG9UWFcrakRjUGpobEZFa0Vr?=
 =?utf-8?B?NFA3RHhScC9hYkFGWWxBSTdxSEFEUERHTGRuazZ3QU54N3cxWGxSb3hESFpH?=
 =?utf-8?B?ME5JQ3dwbTkyWWVOcTJZWXBld1NmZVdndWkzZTdiQkE5ay9udFozcGsvUlJh?=
 =?utf-8?B?MWNLUkVaWS9uaWd5YUpLWWM5Tnh4WGs4Z0xSM0tjMzBJWjhmZmcyVEZOdFNn?=
 =?utf-8?B?dVFIYkFwOEtKWXZ2Sy83SnoyeDJjOGRxT0FRYW5SY0RBVUpCN1MxTGRwZERS?=
 =?utf-8?B?MW5Rd2d5eGt2U201SWdacmlxTzVTaTdjL3VWT1ZtYUtqZGZSSmhiWDZrUDNj?=
 =?utf-8?B?U3FqdnA0RFpiWHAxdzFpRU81WjJSTW01dm5CQlNqdFNNbmVaeDF4SUNaWXJz?=
 =?utf-8?B?UysvTk1aN1FuS2lpdHNJMThzSmJOZG5zTFlQN0lwemlOQUtrcGsrRThNQlB0?=
 =?utf-8?B?Rysvdlg2cWgwMGhydHJ5TWFvMEQ1cVRyVFFuZ3lOQ212em9pdytldU9MK1R0?=
 =?utf-8?B?V2NRNUNaY2FqOHFDdDQxeWp5UzFKMFJRWjNialFyOVBoNDl5cnRPbUlWTHZr?=
 =?utf-8?B?eXFsbVEvajVEcXYybFY4WWlQN28vNVZqYytPNXVkRXVRNUlabDI2ZElhZ0F2?=
 =?utf-8?B?TzhKU3kxV0tiaE1odEdwSEc4ZE9HaFZVeXBxR3l6RzlQV0FHeXJtYSt6cEFB?=
 =?utf-8?B?c29wTldlTUZRYnA4bUc2R3I3eXZrTndzU0htRGFsREFDNkF1dVIwd012bTNE?=
 =?utf-8?B?R3pyZzZSTU80eWMzcWVPU0g0My8rR0tsRzZIUmU1cVhjMjNNN1NuRjBYNGhG?=
 =?utf-8?B?V3UwOGIrdXdRWkxzdWxQZFQzU21QbHZrU0kyZHpzaVJOa1k5N3FWSFBrUWx5?=
 =?utf-8?Q?PMIyFhKBhoL6xim1PG44Hc2pA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5610bf3d-f1cd-4871-afb4-08dde3e3ef0c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:30:26.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1xHw2MTkDbnKqAnokc4oqlZHcf10EOJXFzHRliGqM7m+HBRMuR+YDl/7NwE3fmWO5o7zzOkPT75L3mPlyz0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592



On 8/18/2025 16:22, Borislav Petkov wrote:
> On Thu, Aug 07, 2025 at 08:14:53PM +0000, Avadhut Naik wrote:
>> Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
>> C0h-C7h.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/edac/amd64_edac.c | 20 ++++++++++++++++++++
>>  drivers/edac/amd64_edac.h |  2 +-
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 07f1e9dc1ca7..2f6ab783bf20 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -3923,6 +3923,26 @@ static int per_family_init(struct amd64_pvt *pvt)
>>  			pvt->ctl_name           = "F1Ah_M40h";
>>  			pvt->flags.zn_regs_v2   = 1;
>>  			break;
>> +		case 0x50 ... 0x57:
>> +			pvt->ctl_name           = "F1Ah_M50h";
>> +			pvt->max_mcs            = 16;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0x90 ... 0x9f:
>> +			pvt->ctl_name           = "F1Ah_M90h";
>> +			pvt->max_mcs            = 8;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0xa0 ... 0xaf:
>> +			pvt->ctl_name           = "F1Ah_MA0h";
>> +			pvt->max_mcs            = 8;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0xc0 ... 0xc7:
>> +			pvt->ctl_name           = "F1Ah_MC0h";
>> +			pvt->max_mcs            = 16;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>>  		}
> 
> Oh boy, this pvt->ctl_name is ridiculous: we're collecting a zoo of string
> objects where this thing can simply be scnprintf()-ed once at driver init and
> then the pointer handed in to mci->ctl_name.
> 
> Something like
> 
> static char *ctl_name[MAX_CTL_NAMELEN]; 
> 
> or so. And then
> 
> 	scnprintf(...)
> 
> into it based on family and model.
> 
> Can you pls do that as a cleanup upfront?
> 
> This is slowly getting out of hand.
> 
> And then you can group them together:
> 
> case 0x50 ... 0x57:
> case 0xc0 ... 0xc7:
> 	pvt->max_mcs            = 16;
> 	pvt->flags.zn_regs_v2   = 1;
> 	break;
> 
> ...
> 
> and so on.
> 
> So that this function turns back into something saner again.
> 
> Thx.
> 
> 
> 
> 
> 
>>  		break;
>>  
>> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
>> index 17228d07de4c..d70b8a8d0b09 100644
>> --- a/drivers/edac/amd64_edac.h
>> +++ b/drivers/edac/amd64_edac.h
>> @@ -96,7 +96,7 @@
>>  /* Hardware limit on ChipSelect rows per MC and processors per system */
>>  #define NUM_CHIPSELECTS			8
>>  #define DRAM_RANGES			8
>> -#define NUM_CONTROLLERS			12
>> +#define NUM_CONTROLLERS			16
> 
> I've asked this before but can we read out the number of controllers from the
> hw somewhere instead of diddling with this silly define all the time?
> 
> Thx.
> 

Will take a look at this!

-- 
Thanks,
Avadhut Naik


