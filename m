Return-Path: <linux-edac+bounces-2347-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1949B6573
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8141F248D8
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1141F1301;
	Wed, 30 Oct 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KfXZC4gJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080181F12FA;
	Wed, 30 Oct 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297803; cv=fail; b=XkDJ0Gpj0i9RhZc9uMesyUwUa0fDlpeLmSAFOZcEMEPcYT/YYaFXuI2pm71j/cZtW5Fim2xnDkJFwlnFRsJb3G/46vNLtSIEAK3PqHu7FHeZjtW0pDznOf6UuKKsis53gsdttYL3SehsveWq3SHVpF3pn8ROj9b6qFoGFIAOF1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297803; c=relaxed/simple;
	bh=bqPgKFkRAhot4N8+Di2c4AOu5jYmADw6sErj1JFlcCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfOPvDKaSpBo/xROeyh+fMR9iTzHlALHFjcSFZ2z83y//+1pWe9x12FrtunbpFHgZR/Lxq9JLoRfrhj3VRCPtEopLgRlikr4D14urHh/mDZtaKYPH/075qBfgdAAtwrZ3L56x/Wd0YRjcVgYVyeIWiLm6ndyPlmfRqdMxanx8y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KfXZC4gJ; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwbY0ISFvKOhwBxJDhePkiVx7Y2aqebM+6ETbB2/KrwxW1g5dxyjHQPTIeysSKh8gOLs0nmhZRA46XFU1+8bGQdPwOuG2sevUxmIVxrfiZpS54h4cwIbNPU6lLY3aYU7c8GXaI62HESz4jieziiWpJQoxTzw2hPHq2/e4phZdJg0SGBqImxu9PzNiMnMg0GhEy9rtVIrGxhtcu2twB+jg8G+D8tDe9QsKJ4SFvQpqP+iH3WD8hOfMPFHCs7orxVLVb8IRl+K4Nfa1W3rjYoMLPtCU/9l1h8jvbonHmBJtjvJLHvAFTErTsJamhSilLgErUu4l+nfoAS0PNagySLonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mc8zC1rmPBe1pL8jpXIVgx4Z1OfYghH5qkGgFsLw7k0=;
 b=nS6+R1Tk9Why4j9M0gRHJo7OPXs1tSjBKXn/MRsxiqFXtLvLuDt3RKjAE/MK6Gq1dIBc0F1v4XQn7PHDYS27NunABCOgOgYRUBRG3kfU+32iLAbUj9k/dRbL7BMGJtAr442pxZK73iozWrKnwe+3LntkutPfXWYYe9JRIo97gpGSPLDRQdofQiezCF578mevsyUZD0kvjMgYQVJSiIAM6x4YuG0bDV4/+kEUJlxtyFK0eoFx/Ei3weGxOu6TOvf5Dp00C6AvdlTwsLEVpwtNGT2uQGGetZ5WEVo7wdo0Qs3tGri+dkI6iSqx26NNgl/LOgt7L+9mc+ZUkaeWHIwguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc8zC1rmPBe1pL8jpXIVgx4Z1OfYghH5qkGgFsLw7k0=;
 b=KfXZC4gJOvzWLaZFU2l6sRDHi27jtzO+Q6DjzUtuA5UxmfCVG2coqung25k42HIy/+ompGPbzHowPF7PShOpfkj1lTGVv3MwRWV2UesseB5SNQjECBTQQvdEylM+8R/uagdTPJmhUHMcpTaP8PRf/uyccYciFbk/2SGOAFnK/Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:16:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 14:16:39 +0000
Date: Wed, 30 Oct 2024 10:16:35 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Message-ID: <20241030141635.GB1288714@yaz-khff2.amd.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-7-qiuxu.zhuo@intel.com>
 <20241029213920.GB1229628@yaz-khff2.amd.com>
 <CY8PR11MB71344FF8D9EA706AFA74618A89542@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB71344FF8D9EA706AFA74618A89542@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e837138-03e6-4cfa-6771-08dcf8ed7854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1IvK1F3S1FGNytrcVVHMHNkcXpEdmVxYjQ5S3BucDJ2a2R2Q0xoUUVJOURx?=
 =?utf-8?B?UFBLdldUaXhaL0svVXdveHZtVUlLTkc2SE1JUmlSRnc2NWU1dGJiajM2cHVV?=
 =?utf-8?B?aXRNVklXNzV0eWpMTjNlWTlBK1RMNzJ2UDhDTzlBY0dsSktERCtRd2xxckRO?=
 =?utf-8?B?R2JTcnpOa3BrVzkrdHlzak1IN1RvVzlPQmxyOVhWY2p0bVhCVDVOd1o2OUhZ?=
 =?utf-8?B?TUNnTlRKRnJ5ZTJnUG83Z2l1VUxZcDNZQlFRYk1lUTgrNVRWU0NsbXovSlFD?=
 =?utf-8?B?OWFXOHNqVFNxeno1ZjFRRWFTM0p0WHFEWHRhbnIxQ2t4QXAydmpEV3Y3UzZo?=
 =?utf-8?B?dHpnWUNSdGt5YkFQbkFEckxCRjljU2hEZWh2VjZNckI1TUc0ZGlGOHVvNWtJ?=
 =?utf-8?B?K0FDV2k5eDZ1M2dzZjNMMnNSTXc3dlJHcGhxWDVWMTZBTmwydzZBU1FwajZw?=
 =?utf-8?B?L2dyRzJzMVd6dGZSMUJDeGtuVmhkbzdVL2x6bUlHTjR0QytJaktxV0lQODFi?=
 =?utf-8?B?RHJpYnFqV01abXlpNnhZSURURkQrZ1FJMW5ZeW5yRFJZSkFoSzFRaHB4ZDZv?=
 =?utf-8?B?WTRUMnNEUURjMC9VcDRYMTVKNDFkZERvcEtzNTZwZlNsSVNUN2lqd1lFTS9k?=
 =?utf-8?B?NiszSG03NjNWbGZiNHp2VEdPRWVHRWttc2JTS0IrdHY5VHplT2VNajhRUTVB?=
 =?utf-8?B?aTErR1V6akdqQ1gxZEswSjVZS1RXUkZDTjhjR0l0L25uQ0FvaWx0NmR3L2dn?=
 =?utf-8?B?QVlDK3Q2L2FEdnppKy9FOFk4OGNyTTI4anpGeCtLaVNva0JUKzR5NU90ZzRr?=
 =?utf-8?B?dkQyZzZaakxyczVLSklDbmFHckRyd3RNTHk1TkdySldyYlZPcEFJSmlDQUxl?=
 =?utf-8?B?QjFTeEdRRUtNMWZvelhJNmRRNW5mb09Md2k5UU5odjNIODVjQTNudHVuY2hM?=
 =?utf-8?B?ZFdYL21vTDJENThYQ2hsczNpZFJpQkNYcXgrZWp3MDFEZ3FrSnRjdEhwZHJr?=
 =?utf-8?B?L0dZQ3lFTjFROEhya1JOTjErZXZ1eUxOMUFPUWtSblM2Zi9SdTRKNFFSbjVp?=
 =?utf-8?B?VUpleUVjSTVlNWticlBHYTN0WndYbXBvZ2h3VStCdlpyZ2FieVdkQXJkbW4y?=
 =?utf-8?B?TWpFU2dLSmpLYy9IcDZNcHl0SUV1ZnJJbG9lR3BzNDdLNmZJa01Wa3VKSWVn?=
 =?utf-8?B?ZjFHems4SmJmb2JJcHE2WlpndTdYOVE3QkYwL3IxZHE5NE9pRGlkdVF6djY3?=
 =?utf-8?B?VkRkbklGRWtnRjdZcURRR2F6WHJST2VVUGRadm9YS0NMM3JSRDdYQ3pPY29F?=
 =?utf-8?B?aVhoQzFTdlZDL2U4aWt5aGppOUFrYjY3NkJtYlFKcDVFSDF6WDV6MmJubmRT?=
 =?utf-8?B?dU8zek82VEcwR3N3aE9xZE5zNDdwQ2lySlpqa0pGVEg4bHpBWHJwU1U0S1FN?=
 =?utf-8?B?aGVtays5elBmNm5icHd5SWRhTHRsa1BNT3J0ZTV6SG9MVzNjREE1TXA3WVhW?=
 =?utf-8?B?am56ZlFIdmtZaWtOWmJHZ0Fic3I5cGRyamRVTzN4b2ZwdnM2aGNiUFV6bE9q?=
 =?utf-8?B?Q1hCZXYwUEwxb2sydkxadnVReVhxd0lpSERaYTdtNmJnS3VJWm1ySWFuc0gy?=
 =?utf-8?B?OTU0ZFdQVFFteGVlZDlDMEI3SlBCbzVtZGV6dlFYbVR1L2FKYytRWkJ4ZmhI?=
 =?utf-8?B?R2lqZ2ZXV0tlU3hRQURBUzBLSDl6Rjc4ZGVLVmluWktqbTB1MzVMS0FLUDkr?=
 =?utf-8?Q?Cy4SwoGmNfJuQ8dWteQkG+pl43ZWMRIWgXhHDNY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmVvb3NRbXhOdjM0cUIxREpCZWs1RWxaaGxXMXo0Ukgya3RoSmNjRlRCenlV?=
 =?utf-8?B?NTk1cElCOU5LVEtmaEhKcmRhOVlSeCsxMUdEWldlMEhjQUZZS3RiMUU5TXE1?=
 =?utf-8?B?N1hyeTcva0xTWCsrTmpZNmZrR0hDUzhhVGFiaXY2Y2k0QnFJRlZmTDIrc1V5?=
 =?utf-8?B?Qlh2SXJrNHZDc2FNUzJtcnlhWlA0am1RK2RCMW03bGl1UDJiTUtwVVk3SkJ0?=
 =?utf-8?B?Mk9odWtzbWtiTlF1c2dTVDZBNG1NVXZrREdxTjlEZHpiTDRxaG02a3JaT3Jy?=
 =?utf-8?B?U3VNVHQreTQvdCtONm4vN1VEdGQ0dmdMSzVxR3NwdmZqYXJORVVKTG1qQnpO?=
 =?utf-8?B?YW5jZXF0bi9pei9VTFNxa1g5VDZKTFcxWDY4SzR2c25KNXhZWGRSbUpLVzRF?=
 =?utf-8?B?aTBHNXAzYStCSkdlVUVZVkJOMVBDSnR2ZkFhQnAwSW91MHEvZDNhbmNVeE5K?=
 =?utf-8?B?cnp5OEsxVytHeEpGQXNxSWxmTzM4TlovRnZ3NFlLN3UrQzBwODFkTUpyWDBp?=
 =?utf-8?B?Q3lweWo2K0ZmM3V2eEpvM1hvZGZZLzRWTXpVcFVRSDRDcTFPUWQrQjdZcHk4?=
 =?utf-8?B?UmNPRCtJekphMllJNEFoTHFMS0ZhZjk0blAxeVY2VFNSakpud0VMQnlucHpN?=
 =?utf-8?B?WmFHSFpiaS9HaVhzMmR5QjRaZ09DUEZRTlF5Q3JPbTFqRHpjMXIwaE5wdlFN?=
 =?utf-8?B?TWNycHgxdmxHVDNGNkllRnhrZytBbFNnSlVzbUhLQVBSZmpGWVRuYnVmZm10?=
 =?utf-8?B?dzFIbmhRQ09tejZxdkR5MHIveHVqWFFYNTFUQVc1cVdCRWlFSEtKN2ZlVmNN?=
 =?utf-8?B?aEorVzUwT3NOOThQRFBLSndhRTh0TVBHa3dicndIWGcyMUFzNEhWeWt4SjJx?=
 =?utf-8?B?bXJQTjFzelZnRnkxWFBhdjdGblhWQ2xGRWJmYzVyQnFyS0N1TW1IQ3ZZUlRG?=
 =?utf-8?B?bmV0cHhsVmpmK3BjYVdlTHZ0OUpFN292UitxeEMvSEZKbXc5RnlCL2taQUwv?=
 =?utf-8?B?TWhCN09OcDB6NnRBRUQ4Q1dEeGhEQnlNNVZIU0xlV1BIL2dtODEyTGtvdmlS?=
 =?utf-8?B?UThtRnVmcWlrQ2kxeTdVWHM3Y1A1TXJYeHZvVy91bVZocFh4dlFGMU0wb2g4?=
 =?utf-8?B?TkhTTURtNFBxUUVBRzlJSUNzVU03bk9wMWpNSUhHQkFCMlh6bGh3VndMUGlK?=
 =?utf-8?B?MmRHTXdXTFRXLzM3TG91ODBCU3RBTXlmcndDL0M2Z0tNS0ZNZm1CQ0dPMzlC?=
 =?utf-8?B?ZnVSTmY0OFRNSUtsU3Q1eEpVRWVZazRiY2ZSTERQb2liUFA2RmxwekMzb1pP?=
 =?utf-8?B?cUhrOU8rSkxwak0rL25pS2d2TTVGVTJLY2NTKzc1dThvYmJOd1BHR29Tckwy?=
 =?utf-8?B?VUI4U3crMGIrOERqYTQ2VTZTdWd0Q3MrWCt6SHB3Q1dJMnlNL3VubUlVRXF0?=
 =?utf-8?B?VDVScnF6a2U1cU9lT1pwZ2lSYTFQaXBNZDlidjkvUTZjRkZGNHY2N0NGR0pC?=
 =?utf-8?B?UVp2dkwwNTlqbHRXeEtCVnpGZFR0eklCQlAySnV0d0czMGg4WktzTFkrVkVG?=
 =?utf-8?B?clREY0gvWitLN0ZINWZNOFdBWDhtQlVHNUlPR3BSYktxSFhQQUZaOTFaYldy?=
 =?utf-8?B?amlDWDRiVml3TzY0TUkxWFVHbENhcDVMTUNSYVVOZWNUV2xGL0NkQVozaGQw?=
 =?utf-8?B?QkVhZVo4YjNhTjRjVzFSQ0J4UHN3UG40OHVMZEdsbjN2R3JBanFVZXZnV3E0?=
 =?utf-8?B?Y3FSS0g2RWpJbTlPemFaaDgwRFVLZXJQMjJ2amJhMzBLR04zeE9MSlh1Qk1u?=
 =?utf-8?B?REtORzdMeXdZYU5QWEtrVEwzaGFuK0lOeUpwc3RZSFRSU0kzd3U5VmVaWVYx?=
 =?utf-8?B?VjFVM2k5VnVJUVZoak02dEoxNVYvY1VmbDF3cFR6d2dXUDFRRGtnRWpIb3JW?=
 =?utf-8?B?Q2VhRzRNQ3NzSWhqWEhkSzhaNVR4UUFXMjgxd2NyVjI0OEhvbTU0dFRRY2Jz?=
 =?utf-8?B?WHNrYzM2cnZGTlozVU9wajdydjJWbHBqbmZTQ01YQWZqSG1pVHZZNGlGcE1M?=
 =?utf-8?B?ckVSL2RsNXdhWkk0ekYzOE1TS2ROSVNrRTB1N1g2MFljdmxKWW5QVlJ4Qjd0?=
 =?utf-8?Q?tuqW8AFnBSqoKzOGGF8+0iuYp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e837138-03e6-4cfa-6771-08dcf8ed7854
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:16:39.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIXaiYgnqA5f3VGLy44drKMZEBTbJ+4obyRNlPjYrkKRESKs/kcq/Tp1XJasxKyZwAbI9CQ+TsZW/JFUdh3qJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

On Wed, Oct 30, 2024 at 01:39:43AM +0000, Zhuo, Qiuxu wrote:

[...]

Thanks Qiuxu.

> 
> > > +static void apply_quirks_intel(struct cpuinfo_x86 *c) {
> > > +	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> > > +	struct mca_config *cfg = &mca_cfg;
> > 
> > Is there a benefit to this pointer? We use mca_cfg.FIELD in most other places.
> 
> This could make the diff smaller for easier review, and I also believe that fewer direct
> uses of global variables in functions are better. Additionally, there are multiple uses of
> 'mca_cfg' in the function, the local variable 'cfg' is shorter and more convenient to use.
>

I don't think it would make the diff smaller here since the code is
already being moved.

Though you could say this is a separate logical change compared to just
moving the code as-is.

Also, I don't think the "shorter, more convenient" idea holds. It's not
that much shorter. And there are already cases of using the global
variables "mca_cfg" and "mce_flags".

Why is "...fewer direct uses of global variables in functions..." better?

> [ Certainly, if the global variable 'mca_cfg' is only used once in the function, directly
>   using it might be more convenient. ]
>

There is one such case in your patch.

> Just from my perspective, no strong preference. 😊
> 

Same here. I just figured this suggestion would be another possible
cleanup. :)

Thanks,
Yazen


