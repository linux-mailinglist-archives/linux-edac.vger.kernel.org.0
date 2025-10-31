Return-Path: <linux-edac+bounces-5276-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E433DC26C4D
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D719B4E9675
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297D2F1FFA;
	Fri, 31 Oct 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aSetOUOG"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018C2D876A;
	Fri, 31 Oct 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939280; cv=fail; b=ARGgPqtpgpsNNBPnPQJsBjlk/+rHRDpSkXHtZq5+zO5B2kbBr3C7FBkPXnhcBFWdA4a2oi5iMVi8lYCTvIbX7ntG5OBPSAMwzBVlvtTAhblfWbI6OoKDSvFimwa+GQJXnYV2F0sXwyNXlZC0xTBqiyzU5bI2A/foNuETiC6c5qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939280; c=relaxed/simple;
	bh=e5hH8N0CI6sQ0o/50thl6/wIbCpdmrumCMFNbfzNAkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+BUW2TlAkv9VW/jFiazabfpBEgve9MUbjEx5bQzaIolwoZ8HdQDiqfGyY4xLPm4C9GsVsjSuGuA5gQ3cB/rZ9p0G4dwckFb1ijDQk1yZNsPwoisp8eGszePcqwY4GWR8r6ml/GAGa/82YXsz77JWbsWea0Ukq/8hbIzy1yDWoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aSetOUOG; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7KeQ1tmg9AX7HqUYU/4v6LOCBPGMtp2O1aj2PvTcZe8GYSHmW3Dmwl+e9xi40koLukRywlYm1BY8MWglsW6HssERkze1mYZ/ZhJ+GBPnHJonRCRcEgp17pph9+MswDl/LFCzEL7DdZ6JCbHHok1UfVyEKx8qMDR4/VN38q8RhZelkMwze4q+PqnXNay5vjFl3uBn8dKXevfCds/tK3R9doeoCortsLtDJ8p0yNvk5p6pmJwEVfg3j58MQ/HofZ1G/fMxHEcJtAkGshEMQtO9XO6S+6UbQOm3VHvr0iVEPxqGbfHp8zWNoj59C/vNb/AAIDaaz/D1BB914rSYdBUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXuoQRgHltqLljkVpyW0pwGvJ3DutU0VUAbt5LaKuwE=;
 b=soechzIhVJL62/iW9kjgx1pnzAh2GPDy+eShG/DVcCxZOCQg58FXD9wLMQpj7TxRA1v0R5gTBBSnjEDtmV4mqWqJKfzndiWCgtzge02i0X1OagSjupAYJk1WNVfh/xLds7PUVKuLF3Iel2oq0lKPvO2rFM1mhyQnXaaKuRyBZQA+ElAj453ZnuHabkg6Udje0cVUWJdlzQ178xudEkucFta1aYQJJ0wxC8uPfopSo9tq7l/MSXqx6DSTBEaCc8XozYfufYhymd5mvTlMROdN42lU46Hls4V896XfmrHV/2bq+w+qtI//hyOLJ0pdxDzE/+YaqlqfvnmXBWgUXQrTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXuoQRgHltqLljkVpyW0pwGvJ3DutU0VUAbt5LaKuwE=;
 b=aSetOUOGjzaQ/SzzyRKC21iIrkPBmnxvWU5KnO391DrJIOzRzXHQIy+BeVhQpbrE0NirFpvRi8/hAGwt8PNq0Q97nPYhv+B3+fAgbzJZ8Euz2nzhw59Enhd0daDfECJB4A3JcJQvP7m6OJwV2HjgPoPZtxcHz8HLazUA6cohOB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:34:35 +0000
Received: from CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1715:5a3e:9044:94f0]) by CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1715:5a3e:9044:94f0%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:34:35 +0000
Message-ID: <33863327-f647-42c3-b938-5ded87ac47cd@amd.com>
Date: Fri, 31 Oct 2025 14:34:33 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
To: Borislav Petkov <bp@alien8.de>, Greg KH <gregkh@linuxfoundation.org>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
 yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
 <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
 <2025103029-reforest-negate-cc34@gregkh>
 <20251030191858.GEaQO6ImJ4fbqB_5ag@fat_crate.local>
 <2025103150-subside-tux-fd46@gregkh>
 <20251031125446.GDaQSxllGS9N84L2sK@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251031125446.GDaQSxllGS9N84L2sK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To CY3PR12MB9680.namprd12.prod.outlook.com
 (2603:10b6:930:100::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9680:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad259bb-68b2-49cf-8f8b-08de18b485e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkxTeE1oWHNZT0ZRNlNad3JJNnhuNkkrWmlYc0JpdXZvYlVOdlJSS2pFMnN5?=
 =?utf-8?B?KzJBMGZnZVFuRzk5TnpOODlUL2R3MmxTTU9jck5CRjR5QUNIM1B5dDc0WUdi?=
 =?utf-8?B?U0d4aFZEMXFxUmtmeUFUVU5rR0l3ZHlUK014Y1VrcXl6NVU5dGFWY1Nob1RE?=
 =?utf-8?B?MVdxeWNLN2FsWHoxUzZET2xYZTRFL3VsS0o2YmN4VG9hTUx5dUVwVE9ZeE9Z?=
 =?utf-8?B?Nm1RY25ZN3hYTTdMV0VjckNpUW9XbCsvQU44aG1IQjg5Q0d5dkFJZmJqN1ZH?=
 =?utf-8?B?aGNXWkllU1RNbGQ0S2FZRGk4NXplUDl4VExzWVEwZ3dxeUZCQlJsM3lLUGNR?=
 =?utf-8?B?QWNyUHBoRGpSVzF1dFFxYWtUY25zdW9vYXpqQzYrUkRycHMweGkvdFlBU3U2?=
 =?utf-8?B?aWQ4SHlwUmE1Zml2bVQ1ZGhYYjhsRmNlblMwVXhkdk8rWm1BNUJJbHBvUlJO?=
 =?utf-8?B?eUh5dllMVzAyM3ZWcWFHMThTMXJKbnU3RmhkWnBuYUh0a3B1S1Q4aGdQT2JJ?=
 =?utf-8?B?VStJV2hYd0Y1eFB2Nk5TNGN0TEVzVlNGbC9yQVNBS2xNVGpOZTRSTWZ2THgy?=
 =?utf-8?B?SU0vWjN4ZERNN3BsTHpjdXkxL0N4c1RmU05hajVoOVdqZ1VWTzRweGZod2Mw?=
 =?utf-8?B?VU12S1V1VDNNQ2xFTmVhYXFoUTdJdy82Yk0xSVljOXViaTVWNVoyekFnWmsx?=
 =?utf-8?B?MUd4amV1M1VTVFVNU3o3Snp6eW5WMkl1K3lmWWR1Nk92T0cxT251a1VRekpt?=
 =?utf-8?B?SWxpZ0hhWDlrRWNuOUt6b1Zyb0V3MG5iSnVuNmJCbUtCa0pSdjVoUUJiSzZt?=
 =?utf-8?B?OU1WVE5sN2FmOC8wM3VVUU9HZW1ZbzZueUhZN2ZUT3EvWm0rYVJROS9KSDgr?=
 =?utf-8?B?SGFMNlF5anJqMFhjNTV6OVloQWxaT2JjOG94TE5ycnE2ZHhqcS95VWM1Q09v?=
 =?utf-8?B?VWVYejJBTFVscjNUZUxmQVZTU3JKRXR3aHNaczQ0cTF3elpPbGVsRVg1TlMr?=
 =?utf-8?B?Ykh1Nm5rblRFWDdjL1k2ek93VDBnbEZvWUROUXgvUk0vMUUyVld0aDNMM2da?=
 =?utf-8?B?SVcxR0xXZ1N5MXBaanNhNldxa3pNczFmOXQzNXFYUnlBdG5qUnFkT2RyNGc1?=
 =?utf-8?B?OHRmSVJ4djR3RUljUXN5SlV4Tzlkemg3RTNaeFlXUUpXNjg5bzJnWExRdEMy?=
 =?utf-8?B?NVpHT1hhcDkweElSVWthSGxEWjRualE0K1FwTnBna1JHRTZWNnJ2d05pek52?=
 =?utf-8?B?eEhmUllnYWZ1MHVsODMzQS9vdEVFaGp2R1FZY1ZIc0RxM2JjMVNReTkyRGJn?=
 =?utf-8?B?eHUrQjBlS0UweHJVZk5hQzE3VTFzOXlJejdxWE93aVR0cTRRTENzRjIybzZw?=
 =?utf-8?B?Y2JZQ20zbkU0MUJBNU51M0VIWHZSQXUyVHVNdGs0TDZhV29MMjlpREJVRExF?=
 =?utf-8?B?S1JORllSeE1LV05vak9MUFlSZCt5RG9SdlYxS091SEJDbVdtMTZybzlnS1VI?=
 =?utf-8?B?dmM3dS81ZWhCakhpdXl0TlJwRG11T2JBajZKaGxwek44eEFJNWprOHN2VDFQ?=
 =?utf-8?B?RFcycHM3emJCeUsxdGpzZEYwUVArMUN4ZVdtL28rSEVnTXdCNEhEUDlxeS8y?=
 =?utf-8?B?Ky9jWEZ0WmloUVoxUC9TS0FMTUQxWll4Z0d1YzVpOU91OURtZWFrcy9NemNY?=
 =?utf-8?B?YnhhK0lDQ3BQSFMzUnpoTi9oeWJ3M3VhWGIyRG5CK1JBTHV1aUtnR1U5bFda?=
 =?utf-8?B?SVN5a3lSdkxwb2NlSTNCckZCOGRHS2hzejJUdityREQrelV0NzNQSUlMRW5x?=
 =?utf-8?B?dEtiVkNrNDBSdHlJWU9QMXFPaHhlS3RQeW40c3JBWEo5QkVLS0M0Y3hRUWg5?=
 =?utf-8?B?NWlrbFZkMm5iRFRkaG1uMm1hQlBGZWRPUlNZNXF1VXJ1bURlUWFzMCtIQXpa?=
 =?utf-8?Q?VQRDBECBKByCUkCQWIDxH/n90BXQXMa3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9680.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC9RejhaTVBLTm94eHIrUVZaR3NxckJINWlHUmFvT0xOZTdzQUpFdWdvUWFj?=
 =?utf-8?B?aG1wRmJFUEpWaE43MlN5Q1NuNjN3MUQwNmY2cW90azVidld4VHVmeHp2NDdo?=
 =?utf-8?B?U0pLVWE2Z0lySHhOdGFzbG5OSVBEZ2F2RXFlR1VwTEgrbytUTzFZUUFKSkUz?=
 =?utf-8?B?K1JWYW1pamo5eU94Zi9rSnlVemFrYXBvUWUxam41MlY3WWQwU3Nwek1EU2xX?=
 =?utf-8?B?bG1pUTFpelpiN0pSUGNEZVN1cEYzT1dMQ1orK0MyeitORjNwY1RzdFVPQzVv?=
 =?utf-8?B?UmxFYVB0U2JlU1RjN0lMZVRldFN0dVVKRWRwcFl0Sm94TE0vVWtQT09nd1dj?=
 =?utf-8?B?RlliY0VuUks3VGNYeGgxTDNtb3lVaHlPeXhmZm1ZbWljNzlMTGdUVUc4clpD?=
 =?utf-8?B?VUJBTXNzUGN2RGd4Nk5MREJEN3p5SXo2SmdiSnljSnh2Q09Uc1U5eGpqSyt4?=
 =?utf-8?B?bGtjMzUvR3BjYlpGTWJPTGJSMzJkVTRnQWhHb1FtQ2JiOHF0bzd0UTlHeWt6?=
 =?utf-8?B?VXhGcmNtS3J1eU5FT01ERXNwNFFXclh0T3FLeTIrbGF1V2RwUWhJdS9kcGR4?=
 =?utf-8?B?TVI0U0tlclcwUjJLRU5IdEQ5U3BDNElTTmVrOEVWbkRUS0haRGZselF1eTE4?=
 =?utf-8?B?Y1RFSGhJRkVWS3VpblRZTGlvb2JISXl2TmhkYkREOVFBR25ENjVFak95TFJj?=
 =?utf-8?B?ZENoQk82TjFRUzVjRU1DNXhaUm9HOEM2cWhHSW9MVTdSYzA3aDUybHI3TTZ3?=
 =?utf-8?B?QTIwVWhKd085cy9aK0JwSVRSQzZhUnE5Mkx1YWYrZ1M0c3MxMDVDalBIbzhk?=
 =?utf-8?B?dDZjcFBkdG1EL2d3UE5tem1SSjZXMEtlU3pVREpuS2xmY0JZVVJIbEFOV1Zu?=
 =?utf-8?B?OWVqVnlVSW9CZGQ4Z3YydWJ1dEhFdW05ZHJlTmN4S09zMVAvTC9PTlVwazNl?=
 =?utf-8?B?KzlkbXBPNVFnOWFkWklRRU93SEdRUzcyQ25neUJPZ1dEVEhQbnAxNGpjNUJp?=
 =?utf-8?B?SzJjbHZlL29iTHVablRWbVRRMVZWVlVieERWekhRR2N6Q1dBeExGTmtVSy9w?=
 =?utf-8?B?Q1BHb1hldUxjSkRmZHBJL2dudHQxdFJueTZjYVh0a0NVZ0NTZ0xZZjA0aGhv?=
 =?utf-8?B?K2hOM3ZmK3ptdFRSRTNUV1BJV3FjV0xYLzdzK1Jvc3cyNkFyZlByTlE2b0Nl?=
 =?utf-8?B?TE5hSkY5dkF1WWlnbWUvYkVZMUpjK0hhbkhJQTFlbU0zMGh6QllLckt0MGFa?=
 =?utf-8?B?b2tSamtOMHl6TGFTdWFuK2loLzVxSWFaYjVEK3loL2F6Rys1cExVRzFhK3Zq?=
 =?utf-8?B?eFhUQ1hvZWhpUExOdWNWZTZGc0lVNkVJMVZsMk91eFd5cEg4RWF2bHJ6MHRx?=
 =?utf-8?B?OHRPQkMwMFVrZjJtaS9KTXFnbU0zWUFPTk95NGFleTBBdE1ycU5oT0J3Qys5?=
 =?utf-8?B?NW5JemcxZXQ4S2NwSnRIbTcxUjZNVE52Ui9xZGJIYXhlSTZRQTZUNnI3Qzh0?=
 =?utf-8?B?NExtOXZBN1Rrc3VVYzZ0Z2o0akVVQXlMaTRycjN3K3AxMU81b3FiRHFXMmhv?=
 =?utf-8?B?N0Zja3hJTDZBOG9SOHN4Q1hDU29id0RnT25DQmJiZFlMUFA0eFAxbnlSWXhJ?=
 =?utf-8?B?WkFlOWVDOU5WYTlHVUpjd0ZuTTZuTmFWNGhXeXJsd3VQUUxWRXdKcXd4YVJM?=
 =?utf-8?B?YzJvM09Ra0dtNUU3TmFpQTlmcTkvM3lYUGhWSkw3VmdTbTQ1TkE1bG9WTk5Y?=
 =?utf-8?B?OG5memJ1dldwVzNxUklXOG1lMkFZSTdoZlZSMjRocXNudmJjZFgrbXVqVnEx?=
 =?utf-8?B?OHJuc3ozb2U2OTJ1SHExemsyTmhIU2lJSzFCUWtjUE15NW8yS2hReVJQRHdr?=
 =?utf-8?B?ekdVTkpkeHlHM2ZvN04xZXJlVURLT05FRE80NzVOSEtKNjAxWDhxMUFPZkRZ?=
 =?utf-8?B?SjdNM0lTcVd1R1VPeVdMS0hSd1JpZmQrUEZVbmlYWWFCUGZjNkd5UXpuZENW?=
 =?utf-8?B?SlFabUtQTWI1NURpTm5jT1ZRQk9jN1o5c2hwMkZ5bldqTjFHdWFVWjB4aGNq?=
 =?utf-8?B?b294Z3FNblNPaWtLRStHdmNBQ2F6Wjd5TFhtRTN6Y3lDR2JwVm56MlZ1d0di?=
 =?utf-8?Q?oJt/wqsgXnUBKbRouGVaftB7j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad259bb-68b2-49cf-8f8b-08de18b485e6
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:34:35.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33Hn2iJUdKzI0+u0zDvGTHSmA7D/ak8bvcsqFOjo/+C/jXRzQFMWpZ9gItIXTuck9QWkKwHrar6fajcpP8aR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375



On 10/31/2025 07:54, Borislav Petkov wrote:
> On Fri, Oct 31, 2025 at 01:38:57PM +0100, Greg KH wrote:
>> Yup!
> 
> Thanks.
> 
> @Avadhut: you can send the next revision now. :)
> 
> Thx.
> 
> 
Will do. Will remove the interface and resubmit this set.
-- 
Thanks,
Avadhut Naik


