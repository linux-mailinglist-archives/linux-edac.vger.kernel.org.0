Return-Path: <linux-edac+bounces-4136-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28BAD7FE5
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 02:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07D23B7C59
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192E1CDFD4;
	Fri, 13 Jun 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NsrEVcUx"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BB1DE4C3
	for <linux-edac@vger.kernel.org>; Fri, 13 Jun 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776240; cv=fail; b=mrcS1mvr/piw+LnAxJsPtcLS7LF8xkZvCkzOJoFk6eujWuCDhyzumjtFYQldce846wkR+ZEsJtwpbrF5lQwiX7OSodc/UikHJdLH2p/EYVslXA2l8WthEP3yOBCFf81AuhnLf75fcAbD2EUpZvt6RaxGeVU1KzJrF2kOnL0V7RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776240; c=relaxed/simple;
	bh=CzVgwiQLSXZXDrgRh8WxA8ynhN2FiQRpVk3VPqsWhlY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3yjD82zrGuLvCsDzNlqHAdRt3tgwLaW/FqB17e4hsxT2CNY83suLODi5E9EoLkaqirvgZAexMv5KjHDPyt/2gtIJuQZTXJdbCf2Uor8PwLKmhU5gqIqJn3ISFZYOzz1zdUc69o+QpP2RpAU0ynDRzmbpmCVLunXzIEB6UcOyk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NsrEVcUx; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2kU956owT1jC8TCiTIkwsBsFNJ9hMswkzlOFSrE9wE5m626xHfhStbcP74DONZk41n3YyscmKIMkFQHZfId7dZ2SLpbcSXNLla9YTK6sKdwL/sJXUN8J9btu9NrQvXsIrmuXa60kPUrQsayp4JNGEcmfj6z6E5dGZHhZRAz1Eb39efGWQOUdnT8aoReKeuEQJX12dzWjpOZSmObsdzB9hQbqQnP9xh3BxssGIFouf3knmDnTSwQi3db08RnbDuQDg1P19/DKDd9W4u8gO2xOXiJnuc3WYY1Ab4zONDjAdJ8khvzOMn4iUXuG33qcfzYhSVH72toBSvohjTGITk9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKmyDIJ4DJAfUQT4DBWMGFrMSXBjdRwB4bekEu3m9s8=;
 b=xtHsp90NY/2Prkgy9jCFkbrYfe34a7Gm7WZUZuEURbjX96g1Qx188cjzBI7+nVTPDHmmuAhlPo8tPYQDWLJ3/Ql80fmGcb45BJFV3ikUp5ucBUN2kDVcFkXnSUp05AE7HYLlw1SrGQUR95rdBDmsAb9GTs1OxkrdUlU7DrS7sUo3LnFWuPoxfXDRPBkjBMBbJlICPCkaCyjZwG63/ePMFjw9CplzjWhLjJ6/fWhis1FlhzSriP3VN2FwpjV4vQaDwStsH4Wpu8JJtoDJQYK8jp7U95hhOxvxUho4j1yczdP5EhLmmMNkfAWf5Jo2PpzlaSFmioeTHY67/F7RMpUaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKmyDIJ4DJAfUQT4DBWMGFrMSXBjdRwB4bekEu3m9s8=;
 b=NsrEVcUxtqo+IiJzui3pm1rQpM77R0/4AQME3CjxjyuZ2O8Kq8cjVW/GjzBnLMGIP4G7HwhEi8KvDBHu9eW+WcBJ+tTKZi0LhUny7qJkwwJx8FdAzbgK5Otvq6cWG01VQ/6jNgq47OYaoI8xPN5E3baefh3Eal1Hj7K5qDBGAyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 00:57:15 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 00:57:14 +0000
Message-ID: <7c2641be-5de0-4dca-9e19-d95338a4528b@amd.com>
Date: Thu, 12 Jun 2025 19:57:12 -0500
User-Agent: Mozilla Thunderbird
Subject: amd64_edac fails to detect DIMM with only one ECC UDIMM installed
 (works with two)
To: James Blake <jamesedblake@protonmail.ch>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 "Naik, Avadhut" <avadnaik@amd.com>, "tony.luck@intel.com"
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <WWtcG6KurPUuwF9vO6BrD2SXUmU20OYqRPPpbGD9Oxp9ZmB8KvHdFELQ9zURHvcXiF5WE2UdhZwbGlvxVQV82Srwl7B9bMKvxFhBQyPTET0=@protonmail.ch>
 <20250528164459.GDaDc9i5ngUZlWECaU@fat_crate.local>
 <c1a5dbb5-3498-4ac3-a278-dfde3f005e6e@amd.com>
 <20250528175819.GGaDdOuwb-nzE6FfYs@fat_crate.local>
 <Y2t3NVJDekt0_ZKiu49pm_CcUtPa_2P5J7nfX2pDyU6d86s654OzT0-HkAe70ADRKjkQWPTVEeRxe_D1LKBfGWi2bm4rRkN6r4oxN62GMn8=@protonmail.ch>
 <ICqp-rWBvFH6C8JZr5ejYGojRAJBq4aDTIQxeZ4CpJJClm0ORSvW9QjbrefiVG3Sryws_xpBujUiznDwE0UQ5ETrued4QW9i09uxszKcp-I=@protonmail.ch>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <ICqp-rWBvFH6C8JZr5ejYGojRAJBq4aDTIQxeZ4CpJJClm0ORSvW9QjbrefiVG3Sryws_xpBujUiznDwE0UQ5ETrued4QW9i09uxszKcp-I=@protonmail.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 56234fcf-9054-4df0-7c21-08ddaa153c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUY0cGZqU3VIMU1OL3FSSzRyNlNnQ0hEYm5XU3hvUGdDckFwbjRaL1UxMFU5?=
 =?utf-8?B?SjBtRDJDdStUSys2VWoxTTRKbGlQRUdLWlhzY0RxQXVtWmhNdkc0Rjl3L0or?=
 =?utf-8?B?bEhIRGR3R0ZpSHR4UUV0ZmlkMzQxSzFuSDA4Z3pNamY2bXZWTUR2Tnl1bXY1?=
 =?utf-8?B?YkZGSXIzRDVicGVFMWQvRlp2WUIwQ2Z5UFEzTjBUdU05aUtJbGpZRWR4VFdh?=
 =?utf-8?B?dTFUUWlMbHU0ZmdwTVNiOUF1Zk8rWS9qUnVzRFJXYm5PWHUxcE9OVWo1WXJz?=
 =?utf-8?B?c0ZrTkE1YnhFOVd3bUxuUEc5Q2tzRkZzN2h3dURrQTdRMXZaWUV0bGNTKzNH?=
 =?utf-8?B?YjBhMEZaNHVxK1JrUWNVSkhubEVjdEQyZjNIemtMZG5oQnFVdis1RXR2QU0y?=
 =?utf-8?B?TU01TVZLeklBWWhOb25oRWZKeTI1UkdiTVhCNkxHc3ByOTU1Q0tueUlyb0gw?=
 =?utf-8?B?THdxalpYRUhEWFZ3RTBzZHpJL2NCTHo5YVZIRlFRMW9PNmlmcCswN2RjT3Rn?=
 =?utf-8?B?Yis3RDQ4ZTlqNkdrVG1GYWVOU29NRStUL3B3Z29hUmFTRjIrQjYwWjQ3a0RN?=
 =?utf-8?B?eHgzbGxrYWNJK2pZZ0c5R3pTbUhmOUZPQkdwVEYzZ0ZTMUxNWUQzdmJGR1hB?=
 =?utf-8?B?RGFUcEdJcVdBa0lBMU4wRmQ4SFRMNVdWL3huVGhSODZBaHVJSjhZVFdOVStY?=
 =?utf-8?B?UXh0azN3aVdRWWVmdUVqWHFsSDJmckcrYXlaVUF6NFJHblNCYkJ3ZThxMmVj?=
 =?utf-8?B?Z3lRZEFwUVV0MEdhd1pMa1V1eDJIemswbjJiVW9xRm14VFdxL1ZwMThQSEty?=
 =?utf-8?B?cTZ5WDBEUWxzNmlhRW5XenNXZ284bHdNZ1g5TzJPN2U5Y3RMNXdMaDZjQ2Jm?=
 =?utf-8?B?SFRqQTc3VzRPT2ViMkppQ2FHbTNZQ1V2MDJGay9kTndDR05TSm0vWlBFUHJT?=
 =?utf-8?B?N1pxc1FjTzhkd3VhTkhZODBzL1NjZG00a0dqVDIybWxncnRFZG9QNUZBUm9z?=
 =?utf-8?B?UThsS2d1S3RJSFM1c1BFWUNBVFVGYmJ3dlFEdy9CSC9hNmVkNTlGTVRHVVBa?=
 =?utf-8?B?cWpGZWZIOEVIWmhNVnJTWXRNU0puSjFBMExLK1FWWDFYa2hoZFdtOGNGbVBt?=
 =?utf-8?B?elFVOUFZYmRxTnBVVlQrYVlkZE5ibEJodkVHckM2ZVZEeFczbHN3VVp4OTFI?=
 =?utf-8?B?d0liVmtsWFVhWkt2UERQYTV5bUFXbzZkTG9ObjQvVVZ5QnVSRngxWGJ5QzF6?=
 =?utf-8?B?alVlMVhXVUxmbGFEU2NqTlJ2c0RYdzJPN003cVFubEQ5aHZmajZpMWQyTHpi?=
 =?utf-8?B?MVNyb1JDdmhkcHJUSmVnRFRzWkFkSGhTem9IZ2orYWw0R0ZwejF6SDdzbW1v?=
 =?utf-8?B?Wm56NjBGL2dnVzdjT25UYTJiZkF4OVlER2ZyUzRvdk9WQVl3LzkrUC9Rdm9H?=
 =?utf-8?B?cjFFd2RINlcwcWtIYkFyS3ErdE9zSVM3Vnl1Y2lDSXo5aC9RR202THgyT3Ur?=
 =?utf-8?B?eEtmNHVVMU9tZUxJblJJYld3Mlo2bWlRWkVScDg2WHFLOHlEWDhvTTVwSzNH?=
 =?utf-8?B?K3doeC9NdGtRZzkvcm5JdVJabFVhU0I0RDN5RitiRDhqVzRRaGlXUnVtRlgr?=
 =?utf-8?B?RERTMG51TDlUOGpGYUoxdFMwSTZSN0UrMnllM0VZN21DdUVLZ0l5d2ltcS85?=
 =?utf-8?B?QUxaNnFGcVh3Y0tGdnMydXlybzhwUnlqa0d3U3A0OGhVVmlGVEc2cENhTXhl?=
 =?utf-8?B?cURWbW5oTkdWR2ltUmlMSW04MlF4OUNkQjJHbitrZDJ2bUFid2M4eitubVhv?=
 =?utf-8?B?dUpMR1p0cVNEOS9veE5WM2RIR3Q2cFNITlJwamNhV0xFS29qT2dGV2xhMjVs?=
 =?utf-8?B?NUdMSnNEczlpckVUTWIwY0dDMnd2TmY0ODJnSUw1Vm9pUFB5K1NXd0JEc0R6?=
 =?utf-8?Q?H7ZSOHr8tbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1Fkd1V4d1N0OEpDVzFTWkpZak9vQ1Y4T29LMUJCdnZYL3BFT2ljOCtvMmd1?=
 =?utf-8?B?OUc1OE0vRVpaR3VuZUNVTThMb1BzN1Z6eUM0NWQ5SE9FOGcreGgydk9FTWtl?=
 =?utf-8?B?YkZpVEQzc1J0MUpuT2JXVXlFTUk3QTNvYWpvVVhqUnBiMXpqb29SSXJKWU1v?=
 =?utf-8?B?N0pDUkowdURNbjFxbkUyYXdHeVNXcXZlODRGRmUrR0VkaWRlMzI5WkJ6NU5t?=
 =?utf-8?B?M250S0ZncnpKMXVoWjh6azRvdE5wZ05uMVd1cmVTdGNDL3kyWklTNWFweXBh?=
 =?utf-8?B?SDZtYkZVQ3VaNlhEeWdLVGRVVlNWNTk5dUw3azc0NFYxK1Bsa3Y1NVI1YU9Q?=
 =?utf-8?B?ZlRFSHI2L2c1TDVYV0p5K2sycncvK0JYTWpOajdaa0VqZjM5b1NuWWFPQjE1?=
 =?utf-8?B?aGx1KzI5KzNZVm9oRWxqS2M5VndScWdjb2wvNlFuS29zejhrT2xtbDI1NjZS?=
 =?utf-8?B?Zm5zb2pmTEdnOWdlU1JvQmVMNUkzSy9PR0xqanN0TGc1VWRaUDE3QzlzYXBB?=
 =?utf-8?B?Tm9RamcybDY3L3M3YnpqN2hQMmUzR1BwdDljNGl4UEtERmRYc3liU3ljMFNY?=
 =?utf-8?B?bGhPMDI5ZzYxTG5kY0tyYzNBenliRUg3VUVEWGE5ZHNnTnRLTkE5cXFTSXR0?=
 =?utf-8?B?aTBsbzgxRFV3UHNPQWUySno4Mk9oNEZDSDFSekIzVXIxTGFibGJ5MEtxam5F?=
 =?utf-8?B?TzQvU3h5dnpHZnpSRzN1U3Y4Z1N4Qm45TWRMekExSzYvYVNuV3NxYlhYRDZR?=
 =?utf-8?B?Ny9QSEw3S2JTOGFXaG9oVlh5aC9PV2owRUt3VzF4VVFnK25jU081ZnUrblFH?=
 =?utf-8?B?U3BJeHdZMFhGQkEwODFZaVIrVm1ieVh5QmRCTlBXOHpvTGtkSlJvT0VJZGp4?=
 =?utf-8?B?NEFEdzlSUzZETHFjbE50S0p6UzYwVHV5dWZ6TWlZM3RWLzZzSEIxcWJscUhq?=
 =?utf-8?B?NVY5amVzQkJzdXBmckdQcVFoMUJNaFRBaWcrYjNLWDJ6L21MYlBpZitLZVBX?=
 =?utf-8?B?QURmSHZSUkZtYWFialp0S1BFb3QvdFdKdDQ1Sk96NDJwRWJ0L29yTFcweS9Y?=
 =?utf-8?B?VlZkM2swRHRXeWIwZEdWSDRQRi9ZU3pEbjNJWFFYWmQxMDhvZ3NnOFVrNGtD?=
 =?utf-8?B?TVVTUDBtSmEzNjZxMDZla2d3dEx3WlgrOFY5VkYycXFNRlNUQ3U5eUVXY2lD?=
 =?utf-8?B?enYzeml1N3ZEV2FGUHJ2U01OblZWTEFFeWdUMTFOS25iK28yYW5xZmRBb2hJ?=
 =?utf-8?B?WnlBbnJMb004c0VITEpacW1tTVBqM0tYRE5QaUhIV29YZGFGSHlQOFdMLzNB?=
 =?utf-8?B?SDR4TWx0VVRlZFlObUlFRzVFdXlKKzdqcjBvazZQUmdPd2crRnVJMU1kOXo0?=
 =?utf-8?B?czltRjZmak9xQ2J5SUNydHJKNnQ3UUk1eElpNldpSjZJc2Z3bzNsbWJoZGFQ?=
 =?utf-8?B?cWU2bGJCOVF6b0NWQWxHZmNxbUc4ell6amxwUDRERXpHWEoxR25yaTZ5WlJ2?=
 =?utf-8?B?ZHFtTEdIQW9ReERNcjMrREtmdW5tV3U4MyszZUVKY0hyKzlXSVorY0I0blp6?=
 =?utf-8?B?RUlRZGpkL2V4b0dKaHhMcUJNZU1wUk5md1AyQ0dsaldTcWdKNzE5N3ZpODY0?=
 =?utf-8?B?ekJHaUFhUzduRnhoMzFIZGw4b0RtS1hjY0dSZEcxSWNoYjF6T3FNbysxWjRs?=
 =?utf-8?B?UVJxMkkwb25iNTU3ay9CVE5EekYzcGFydDIrSEtadnhSbDdpd1VTTW1tcytY?=
 =?utf-8?B?YzMraENDd0gxQmhzTURrWm5ZS2JST2VVejQ3eHVXcTJiTTlSWjlNdWhpY0dU?=
 =?utf-8?B?c0lrRFdyODkxNktQMHJ6RXR1SGkvMXp4Sm1QcTNnZFR1RmxqenJJU2I5cGFm?=
 =?utf-8?B?aitMOXhLSlFDZTBwM3ErZWphQnMwV2diTWNHbWN0UVFTL1FlWW01dG9HcGI4?=
 =?utf-8?B?SjNuQkhYRmovMEJhc1VCNjlGMlVrUUhJZFArK2ZnVTdodkx6blEySC9Zc0ho?=
 =?utf-8?B?TVRncGtlTEdSV2ltcVRTaXJxQmljUkE2UytCOXlBOHlwNElXWlE3R20xOGxW?=
 =?utf-8?B?Y3hJaElmVlJnUTdHakJQRnhMZVdSUy9JRDZaYmdrZkFtV205ejZvemdDMEl4?=
 =?utf-8?Q?uf2yptw6asMOI+5eTUOFthjJi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56234fcf-9054-4df0-7c21-08ddaa153c6a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 00:57:14.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p6PpjNXqfHmdRfoU0fZ1C97a50bJgn1JnO0+7NPDeuBVc+24S7R086/ruXH4ynzkYSTv11oWnSC/cqVPaldwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

On 5/28/2025 17:22, James Blake wrote:
> Just wanted to add something I just noticed.
> 
> The `dmesg` output from when both DIMMs were installed showed this:
> 
>     EDAC MC: UMC0 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
>     EDAC MC: UMC1 chip selects:
>     EDAC amd64: MC: 0:     0MB 1:     0MB
>     EDAC amd64: MC: 2:  8192MB 3:  8192MB
> 
> but both installed DIMMs are 32GiB dual-rank, so I expected 16GB per
> rank, not 8GB. EDAC is only showing 8GB per rank, totaling 16GB per
> DIMM.
> 
> So even with both DIMMs present, the driver seems to undercount
> capacity. Could this be related to the issue with single-DIMM setup
> not being detected at all?
> 
> Let me know if I can test anything else or collect more data.
> 

Apologies for the delayed response!

Can you please try out the below patch and confirm if it fixes
your issue?

https://lore.kernel.org/all/20250613005233.2330627-1-avadhut.naik@amd.com/

> Thanks,
> James

-- 
Thanks,
Avadhut Naik


