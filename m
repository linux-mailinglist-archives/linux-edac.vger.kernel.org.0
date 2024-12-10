Return-Path: <linux-edac+bounces-2682-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 483909EB852
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507CD16425A
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2024 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63C1AAA15;
	Tue, 10 Dec 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aDIW++Ha"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39F1AA1C1;
	Tue, 10 Dec 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851934; cv=fail; b=haRIfh2eZbTnoedLafjZcOPDYnNyPGWvTUVJicgv9mwWXcFLmMindX3XXagka1VJjGPenlNJUrkOt8rf3MRorAqjnMD6FMk7QNjmdmX6FYEBDOVyivISMlIjbTKWMedIRJUm+lYbznd3G7Iujt0HOOhKHk26GQxQTdEK38SAKaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851934; c=relaxed/simple;
	bh=HR6U6th2+P7gfFxrQLpP9m+ySjL4o9upFCBs/L1qXj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JbE2YFaeoPx2K6LyvXh9/qFvhTu7MoWiAZdiANY+jMENoD+PWyPhMiWEw0dtdiJamucIPpT/yecUEXqrDU9GkLmK1gMzk35ppmg95LPf4jhc316N8RTjQGP7KPqwE6NUKTVwWxzDeX2CY0UcnmnvCMx2GQOstgf1KapZxxhi6/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aDIW++Ha; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahGSrOXZ/DwQlPF5Qq3c9UwDf9yEQQEsv00FQSx395flxi7Y3mv4h1afHxFAlk5tCfF5Bc2G+21V2VGHR8XnsaddNBQUk4cF407DXXrXQm8GnYB3FiSCk2qDfjeMc0bPggLKqpT0ZzOy+j7z6A1iwBo6hpbfTwj2hT2yD+NTiCWHAZGd0UeKCqzJ6GOcxJ4TMM/a13Fmt/RcOHLtnqfy2I3kL/WlWhZHCJHm3cz9zb3JD2PwogAg2ule0FWTGIPnxDCFAfIcfaimKx/R1xCohLy87hR9Kxtr/N0WPrnJbOUBw9VtaB3WVT+sznXOUVx6VRM1JOdUta3AafkdYHd/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRi6JZMoB4VRNM3Oy9ECpw7ixilJmFM3cuu4/jVs+tU=;
 b=XHleul7rwmRUkO6NM3DKPzi10uhipODtbOs0UaKNw1RnUH3UMSKRbq/neK6R3T2CwMm+YJ/BHat6Hf4yHOpp/RJYOl495HuskfusRpINWHkZpJVn7uX9gCgmVoxnAUtz5WYqKpDL26en+2WMKBnDLbSi6Jafj3w+Vgih4U86mx5Y81qw16ZJo5bFOzRGzhB+iB98bmEDEGLFTFfB3NYXruyh74Bz2tglz3pe+uRnUfycHb/dk41eS3GLunzLmftjWVK+MxdefhJHGsuuNBfEM+n6tpI8cGm29sPC/M3c4CvvBdPV2zLBpFsa+e98bDKR8lhzoB0KghATvVrgOtOFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRi6JZMoB4VRNM3Oy9ECpw7ixilJmFM3cuu4/jVs+tU=;
 b=aDIW++Ha9aNvS0MO7Y3JvEejdJ+VruD2fmYXFpeaVIvT0YP2Rl7sfOwISw/KeKfIx9IgsYaTT1jWHm+un+fww1FqBtWmF6P+Gxj1x4h3mac+V3MTg1/8UtjT1iSsmCpa+rSIsjtchMXbL6fVnmKJ9qbNiw8jrW8Msr1+Qu7h7DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 17:32:08 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 17:32:08 +0000
Message-ID: <a3990569-ebf8-4c6e-95f7-851312ea823f@amd.com>
Date: Tue, 10 Dec 2024 11:32:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/amd64: Fix possible module load failure on some UMC
 usage combinations
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20241209215636.2744733-1-avadhut.naik@amd.com>
 <20241210095517.GAZ1gQBcS2BKA30-GO@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241210095517.GAZ1gQBcS2BKA30-GO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e65eb7-a667-4300-7390-08dd1940927a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWpZTDVnR1RlekxiYmNGSmhXNWw4SGFScmZnT0l1WEFMYWFRYzVlb2NGU01v?=
 =?utf-8?B?aUpGbDN0VzZ6TjlzWUlIWTRVdU1FVEZHR0Mrd0cwNXhIZmp6Q2EvZHFzUjFK?=
 =?utf-8?B?aWxPK1pPOEdMMVVqbDR4K3QvdWthemF3NGRxZmo4dU5BM0s0SlhOaDV0ejYv?=
 =?utf-8?B?cFFXWWxsZkRIT3ExU2ZyRHBXTDFOc3VEQzhjRjlWdGdKbDhRREljenFZN3M5?=
 =?utf-8?B?TkVaY1EvYmFvSmJwaWNDd0Y2L3JBZU5GaU9HQXFKaUhucXBjV0t0TkxGdUdl?=
 =?utf-8?B?WHVWRTFPbGNvalMwV0RCbm9Dc3psUElQM2NNaXVVeUozOUtWQVZrbnoyRG01?=
 =?utf-8?B?QzArUDFVd2ZVaW5DQlNiQ0Vjb3hWc3hRdEpiRnB3bVlHOHpORVlxVy8rY3RL?=
 =?utf-8?B?R3RhYXdBZFRaNHNtNXlIRmZpR1dqVGwybXNoUVRYc2hPSytwU01YOHRITyty?=
 =?utf-8?B?SHo4d29teFlLcEliSUtNUHI0WThOS0tvdnFtS2pySFlFcUp6c2d2OEphWXRC?=
 =?utf-8?B?S3dtNlF6aWVzZTlLZTVHSDVhUFB3b2p1Q1E1QTJ3b1VJMU4zTmNzSmRUT0V1?=
 =?utf-8?B?RkV2VWZVaXN1RWFjTzZtdkhQUGVXM2F6NFlUeU1ScjVkVmQ4eFRKQUtlaGcx?=
 =?utf-8?B?UmlqQTl1djdMdFJwdFRhUjBSaHRWd05IQmV0TEpnbFhCckd4eGJzTWhwcHNl?=
 =?utf-8?B?dEx4SVdiWjVVV2dSQ25iQVZ5eTRsVUhPV0lNKzdkOW1VZ2hNazl3bm5YQ2dR?=
 =?utf-8?B?YUdPQnlqZUMrNU1RNEZaT0JrbWxaY3NpSkhEQUVMaXlsaUtRaklXc2dCelVW?=
 =?utf-8?B?Y3JrWFFYMVVxRzI0dHpIc1dUOXZYc1JtdzM3Y1psNUhiSjZKelZHZWdUUDd5?=
 =?utf-8?B?MGdLU2l0b1ZSUXp1bEp5c2d2b3U0QnhDOG1Ha3RxN3grRTQrU0E3Y2taSzhC?=
 =?utf-8?B?d0ZaWktPVEJ2aWFtY1Z6blRwYWg3bXR3QnhweXhkeVZXVnpOSU5aZ0tMdTcv?=
 =?utf-8?B?djNLMXJMMFE0V1Z4ZHU1ZTNpVEF2QXV4ZitjWFBETkt1c05kQjltVU1XSFJl?=
 =?utf-8?B?QXRHMnJMYUdqWU5VR2hNSGFpby9kWXRqdWhsUy83YW5LdjN2T2NrM0dablV4?=
 =?utf-8?B?SlBFRXY2TzRHNXhWVTNBTjJVY3Q3TTFBQ3luNGhwOVJTME1iRGtNSVN5NWxN?=
 =?utf-8?B?THhod2NuNlRqRG5yM0lCS0l0aXVwMzY2SEIyM2FOL3FkRlVIZTc5YUJFRG52?=
 =?utf-8?B?NU16L2lXWklWVUhvWk9QaVpCY2lza1BNQVo0VTF4UkdXWmVkYkd6VkVFYTlJ?=
 =?utf-8?B?dSt5RDR3TFRsUXd3UWVHeEVxRXJvcTZqaHp1bmJRRDVsTlRCdFA4YnJkSDJm?=
 =?utf-8?B?dkFNcmQzdW5tV2svNVBQdEhoVkpBRDNMRksxTElDaHRoNDVGbFVBRXE4N0R5?=
 =?utf-8?B?SkZ3dXd6ZEFVZEczTXVaZDFpTVdyZkd5ZmNEY3B5bjlMQk55YmdmVUs1SDV1?=
 =?utf-8?B?WWNhMjdkRWRaaktlMEtxNVlWbzc3S2dMaGZoenV2MHAyWnpybzQrazczb2lw?=
 =?utf-8?B?SmtycmlVekE0WEZ2aWxqQTMwOUdycEpYM0dwT3cyUUVMU08rUEFHaHIzTXM2?=
 =?utf-8?B?YmhDTjJNc2wrWE0wMDBIMFdiRnNicFhYci83YXFHc0JiaE1ucE5KS2tNR2Jr?=
 =?utf-8?B?bUFraXMweEpwOFBwVnY4WmRhMVlUV0wzT0hZWkRoVFNPMjhkdmhEYzZxRGZV?=
 =?utf-8?B?QlhlUWxQSkJ1ZklqbFZwMmQyWXVPeXZiS2I0L2czQXpja3gyK0tzM0laVm1K?=
 =?utf-8?B?TWZEcjJSZXBDK3AxdmVaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkZkSnF0SnJDazAxZVVJRzROVGNLanlja0RVSFdUekZwUHNkRVhHWUNHUm14?=
 =?utf-8?B?RFZHaXg1SUJvMDlvRXZQRUNKR3doN2NCcW13NHBDdlFUVnlEU0V5YkFqWGkz?=
 =?utf-8?B?Y2hwZ2lwcUFHaFVXc2dhZkVISml6STNNS29WeUs3akRHdjlzN2JMUjl6Umwy?=
 =?utf-8?B?YkZNdkxsenpWSkxVZk5ncjJkcTQwU3puQU03VU9GdnlibjEyUlJTa1Q3N2xT?=
 =?utf-8?B?N2J5cUxlK2hwOXBtYktTQjlhWnRuZ3NHaFlYYmZXTEIxTWZXbkNDTFJDenMx?=
 =?utf-8?B?ZmhlbEpSQm5aSm9ER1F3eVVFQm4yb3MxUlg0VlAzMEhMaHFUN2l4cnNjdUo5?=
 =?utf-8?B?RTFXZCtYOWFzaTcwK2NYRGExTk1uSEZwOXovSVh5TGVOanhmVjJRRUdkV1ky?=
 =?utf-8?B?STVBNEhaM28zR0hYVWNtbWRPeklyNzR5V1hUYmgyZllHYnllSzNXL1lYa2FV?=
 =?utf-8?B?NXdCZzhMSTc0OXhlU2RVajF4ZGJGazlaZmprM1dRd05BYWtBdTlGcnV5bkRy?=
 =?utf-8?B?WEJFS094QWpuK0VvMld0N01QY21KYVh6MGhOSlRRcDl1cFdQWFhWdGxFSlk4?=
 =?utf-8?B?ZStvcmpOM2VxS3BMdzA1Wk1NeTNmNWFBR3lpaEJabVZmNStIanFYNzd5dm4y?=
 =?utf-8?B?UXg1TUovVGx3QVp1WDQrcjVaTXMzdGVCZ3hFQ2lVU0ZXL2N3VVJFd2pJVHpE?=
 =?utf-8?B?cUpuME1NZm1sZGh4YXlETmNYNTBrMnUxVkhjNlVtNmQ5Rk54K0RHZi9xWXR0?=
 =?utf-8?B?SFVqaGV1WlVnai9DeERUTXVzcUlMRFhtbkx0UHozZ2VWUCt5elU5VHQ0VEdh?=
 =?utf-8?B?dHRHTjUxcm1JbExzQkxZWXNaMkJjeDVRbW96TGh6cTdQb2YwaHcvVGdtcUJr?=
 =?utf-8?B?Y0NldHJHVkxadnNwN2xIRmgzcVZZcllPNUt5b29MWnFycTlOc2dJL0tTUExx?=
 =?utf-8?B?bTJSZG82amd2UVUySXhnb3lMMEwrR1hvdVFncXBQUWVuMjUxWEpQSFFpVjhC?=
 =?utf-8?B?Ynd2Tm94UllMYkxUbmJtWWw4RDVZaFhZTXBvRTFCaThkQnRFdFJnZFpRRFFQ?=
 =?utf-8?B?NGl0dXRpM2UrN1BUR21JOXFacnpkVmJGaHAyVk9ac1RtbkkwY29xYzRIRDNr?=
 =?utf-8?B?K2FLTW5iUU9DbXpRMG9KQ1pkNURwa2VadmZKKzQySzRvQmFoMEdDOUFmZWNW?=
 =?utf-8?B?ZlpMNXFBaUVyVkhVdzQveG9XWTJ0R1JjY2lTalhuV1RQQVNxWXl0MHNtT1BC?=
 =?utf-8?B?cmtveCtLSi9OekxUQU9TTDltTXB4RmlmR3hGMEthdUtWNUg3UU5OeGpwU2s5?=
 =?utf-8?B?S3dDL0dRNlBpcWZSejU5eUpQRGhSTGtSd3ZKL1FlWk4weDVrcUgvYmgxTEFH?=
 =?utf-8?B?WUFhNzdINzZGOGFWQTJqVzZpK2R2SEhsdWxOSGViMWxkRGlTT1RvNDVIREg0?=
 =?utf-8?B?c2swb1hHOXlCTUJHVlFpVUtUWWRKRFlackNNUnlUYlNWc25aOVpqRm1CdXg3?=
 =?utf-8?B?ZXFBZDZuaitqRFl6STNGOFNyd0wzSWY4ajgwdXJQc2ZQMWtycXRlbjZ2VVp5?=
 =?utf-8?B?ZUJEV3NhWVpNdEQxN21uOTd1M3MzZEtOanptUE5sUUc1MEkrUzdsRGxCcmNE?=
 =?utf-8?B?WXhuTmtnZHBhREl3SGIyWnZBRmhQWXF2RVZsZkxhT2xPbGc3a1ZFZHhaUzJT?=
 =?utf-8?B?QVU0TjN0bUFYOTdYekt1alVWQ3lmNlpjSkVIS3dPUW94N0cvdEtGT1JSUUdl?=
 =?utf-8?B?a1U1R0t6dkdPZUFtQmpLY0d0c3gyYUJOQTV1R3pySWlkSEFBL0lCM20walNu?=
 =?utf-8?B?eE8rWlFKWnVNVzMyZXlyUXBhWWdnSFN3M3NmMVBUT3NjelNFUy9hZlBrS3Bl?=
 =?utf-8?B?cDlvYlJVUkc4bC9pazBEbXBORlFUNUFIM2FKQjJMaVN6SjVkYUxKa2lKakpT?=
 =?utf-8?B?SmhZcEV6ajg0Y2dtNWlPNWt6TmZXaCs4NHF0eFFmSzN5d2Jqc1VMMGlxRG9W?=
 =?utf-8?B?NnpBVTY4d0NKeVpPVFNyUXlrTE9wRGtuZ1NkSDdiZDB3dFZhQjZ3WXFPR2g1?=
 =?utf-8?B?eFdLK21XWDkxYzI5MjdLWE1va25wd0wxcmdtaWVzUXExTDZZSlh2Wk5QRklB?=
 =?utf-8?Q?MqYWDy3W6KaW7VQWZCHzvElna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e65eb7-a667-4300-7390-08dd1940927a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:32:08.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpsTv5tivge8wXPLHahuV+65PW6k+lyT8fNaa2A/DmCnv7x/A1KFraoa93EUeBzx9brSwadjE76nYQ0LBHW7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121



On 12/10/2024 03:55, Borislav Petkov wrote:
> On Mon, Dec 09, 2024 at 09:55:10PM +0000, Avadhut Naik wrote:
>> Starting Zen4, AMD SOCs have 12 Unified Memory Controllers (UMCs) per
>> socket.
>>
>> When the amd64_edac module is being loaded, these UMCs are traversed to
>> determine if they have SdpInit (SdpCtrl[31]) and EccEnabled (UmcCapHi[30])
>> bits set and create masks in umc_en_mask and ecc_en_mask respectively.
>>
>> However, the current data type of these variables is u8. As a result, if
>> only the last 4 UMCs (UMC8 - UMC11) of the system have been utilized,
>> umc_ecc_enabled() will return false. Consequently, the module may fail to
>> load on these systems.
>>
>> Change the data type of these variables to u16.
> 
> No need to explain what the patch does. The "why" is enough.
>  
Will remove this line.

>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/edac/amd64_edac.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This looks like it needs a CC:stable and a Fixes: tag, right?
> 
It does need a Fixes: tag. Will add that.
But not so sure about the CC:stable.
Quoting from stable-kernel-rules about the patches that are accepted into stable.

It must fix a real bug that bothers people (not a, “This could be a problem...” type thing).

This has not been reported by anyone yet. IMO, it classifies as
"This could be a problem" type issue.
Would you agree?

> While at it, you can simply make those vars int and be done with it.
> 
Okay, will change the data type of these 2 variables to int.
> Thx.
> 

-- 
Thanks,
Avadhut Naik


