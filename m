Return-Path: <linux-edac+bounces-2174-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BD9A947F
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 02:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2846282F72
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0981E;
	Tue, 22 Oct 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxeplNEv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAB360;
	Tue, 22 Oct 2024 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555641; cv=fail; b=QEWCqOn8jEiYitXUNGgKJ46O1C8oJWzDkv7d+4mW2NalSMXcd2fhLDUFPC5gFy9jFFdPBOnxWrNv4CWs7QryCpWxUJ84V7GulAyNTqMvwp00IPzmnP+SzYwp9m1t5bBVZSK6I22qvSBUDegXbG8vjfEj4wwT26yDCSMQ98He9c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555641; c=relaxed/simple;
	bh=wt8d7HCMUFXbNuFIqT6qvtnAazBIu/FMKb9F8qrv0KU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atnbsqlSk+Rj1m0plvpnciSsMT6iVJE+FqVB1090ocFD1BPP59tzVo6LdTuEsZBBz9Sd7xdYHZSZHGWJLTEDVmoOhPkOgr9mFGHjVIEV7Wf6XZwuwosiAIfm1WL5OBycBmNMClVJ2Ju4nBOu6n6k2xPrwoj/Kf24jDnywTZRNPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxeplNEv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729555640; x=1761091640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wt8d7HCMUFXbNuFIqT6qvtnAazBIu/FMKb9F8qrv0KU=;
  b=GxeplNEv1Mvp7ukoL8p9PqAf3ejh/RD3rF/K4MVF1hbsOuNcRmSb1nAH
   XyCz3jnAeaw8xDZjvXy47MV+CP+Q/SgSNpfwYKpFeJRRiaCyQoNQLqhEV
   n/TgeUbFzYNzU8AZ7zTbordiyYhJRoOt0ftf3d9YtUlyYKQEmOcx9lnAK
   xcEG3MkMYxDg88kstTuxY2mEDdZ4aJEqa6FCf9v07DYqWs4ORFTnr5WuU
   j0yIC8F2Tf61ZvWZshS8gJnWUw5dP+9SigvmFBnwrrXWSOEZkymkd4/o0
   AgcYkl0qgvio9YAhdaGiONgsVKqzaN9DBa3ODI0KwjadzV1c0uV8BtGff
   w==;
X-CSE-ConnectionGUID: xLbBwBkARlCHpVZ4X4liDQ==
X-CSE-MsgGUID: khI+66M7RQCCfCfZdy4Vmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39609089"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39609089"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:07:18 -0700
X-CSE-ConnectionGUID: g9usFZ0XRVWLP7I0zYcSiw==
X-CSE-MsgGUID: MvPksY+cR+yXz/99BAm7cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="117111415"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 17:07:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 17:07:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 17:07:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 17:07:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 17:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag8KG7DhtvUfKKcqWBFFMXbNahEBfrYn1hQl3ifPfTHZAPvqeQ60MJC+GJA20Raesi3kDsL10D0Q8449HybxfGojh7DcD+HDx8qpY5HVG4Z0u7de03mD/nKH57lC1Nx3aU0YDAVjGrE/ksUxYlpMd8vWLApNrOLnhnpH2709xkhDZLonT+sSPwy1c2s/6LdCmX9z/aZKIc+vTt3zz8yqFXC6T3USHB7nuuVqH31TNMJkQc9MsaLaxnp6hUf2BkQmAE42qGpIEiFp7MJ0AjJD5kq1KqtdfcU3ArZf0ISs5oug8GKraZUiOdWECzMSz6aMtEuYg6F9mIBmnJolibYucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z4/Wbkae/zRXwNB6WbPrF2psobsN1ElHq/t0AMNEdc=;
 b=F/Vaq1xy/mqtHXxExtj7Ykptpt3Cm5c7AE/2eBbzzfqEmFJi+RAR1Z8tbTwmOwm/tenKq8ZRsPt7klpCW7vqAQub01Ljsruuhgf9wyEs+wuh43EBmmo+ipbrH5AgMIdWyZMdcbS53mz6J7xZIF5S82GY8VT6eHKXXTZd32O0t2v6J0ZrAbWB3FPCLQjLVrIOwOKmRnfjkdPQHXInBKjv4QxMRQQk7S0INr3O9yuaAYQUABIslkZDa+ETTApDrY5deUlGKHXRfmBo9NfoBrQdJb/Ap+2LjGnNHCdmVcEA2HwumXNC41CEZgm3NmMsPeKGHgw2ek/txlT1HeEgmLwOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 00:07:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Tue, 22 Oct 2024
 00:07:14 +0000
Message-ID: <0e0450e8-45a1-43b0-8ffe-55e66477b6bf@intel.com>
Date: Mon, 21 Oct 2024 17:07:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: "Luck, Tony" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
 <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
 <SJ1PR11MB6083740D3EAD10DCDCA12EE8FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB6083740D3EAD10DCDCA12EE8FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:a03:255::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: d7251f3b-185f-44d8-2bb5-08dcf22d7b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3dXSVFJQTNtajFneUlUTUloaEx5U3h4TVMxcm1YbWhuSHBCVzkzdFlQa0NV?=
 =?utf-8?B?WldEN25HNzU1c3ptZXNLVTc0NU9aWEJSSU8yQkVCb1lnS2c1aW5xdmhQZXlM?=
 =?utf-8?B?MklsQ2VyWkFGS1BJZ2JPTWZKckZLWnkxSzVRYzBCWG5IaFU1RlJReWZVUmlB?=
 =?utf-8?B?bFRTcTk1dGtzWDY2em51VERTVFRhN1dPdkxMaE0vcmt4RGVlYXFadWQxR2ds?=
 =?utf-8?B?WjBPbkVvR0lWZ2hPQStOZy91RFpyN1VKUklOaUcyNUdudG9yeVM5cHVpeHYx?=
 =?utf-8?B?S2NMN1ovL0NIM2VtRFo2cCtKcmNxd0pnRGJYa0I1WGZlRmlhTklqOTF0ZTVT?=
 =?utf-8?B?ZHZtcXdBUDFGZVlab2JmcVVBNUplOXNJVjdlQ0dtcFhlMnQ0eFNoZzFHaysx?=
 =?utf-8?B?SmZnVkZBcVhiVWJVY3lBSSs4YTFRRStPcVZYUFV0Kytkb2R5RlJwdWVpMTlk?=
 =?utf-8?B?THFpbkM4WmI0WVdsQ0U5N2JTLzFnQTh3ZjFqYk1iRDErdkFacWUrRXBLTk43?=
 =?utf-8?B?T3E1MnAycWRBNWFhYzRCUHZVOUlRNEtzSU1DeUEvNnEzNEZFMCtad3lza3FS?=
 =?utf-8?B?VXdMZjQ2YVJybFAyNEZUd2o4TUN6RHFuZS96dDErbzUySUxaQkVyTURTNnBh?=
 =?utf-8?B?YUZVZEJOUnU4eERTN21RUktOc1UzYys0N1NvMGJ6akdKSkxJaGYyNkdMdG4v?=
 =?utf-8?B?T0Zra1BmeGQ1Umx0ZE1ESDlVRmdza1JEWmxQbStieUlnTDhCWnB2ekY4SFNz?=
 =?utf-8?B?Zm9HR0tGUWJCYmJHejQrb3FQUDhVOTdQRWVYdGY1Nk9DN21WSXAxeE42UTNM?=
 =?utf-8?B?TkQwZ1o0S1h4VlplS2hIZGsrZ0VxUnUzbFN0cFpFelBlSFhUbVBCVkk5QTJI?=
 =?utf-8?B?LzZMVDlXcEtWam9CNExXYWc0OGZkYnVqVEZMTHRCNGFHejRZUUU4dmFIM2lM?=
 =?utf-8?B?emJzNkY0cXJUUHFqTndpaklWQ01YTnRxcU83bEZwc0xFQkdXR0RWaEFYTDNT?=
 =?utf-8?B?M1QzQlA1c29XNy81RmhjNHEzTVk0RjRweW1mUXdBazlZYlBrRy82V0I2VmVU?=
 =?utf-8?B?TFEyNTAraWx3RGNCMXJlN0YwMFdQY0NzRnhLVU96dFlaaWRQeUsycUM3OGtJ?=
 =?utf-8?B?NFExZlZQQWdlVXB0VXpGV2QxWnNZNVZNK2V6RkRYZDd4V3h1YVYxRkREczNi?=
 =?utf-8?B?enpoakhjNXZ3OWFUaEpldDcwMEd2NmIrTXNMcjQ4cXYvT2hFbGNDeVhJeDgv?=
 =?utf-8?B?OG9vUlB5eGJPbXprTElnTU1xTGFta2hOTnRlb1B4ZmVNaDJrMXBtZDc3NnRu?=
 =?utf-8?B?QzdSaXBmTkE0dEFUdGZjdnZlc0tmazB1Mk9jWi9hMlFidEZFR2d2d2pqVENp?=
 =?utf-8?B?NEM5N0c4Y05kTm9SWXMxWlVOb1FsaVJuY2J6TjYwWWRhMW5xaFExeENkYnZW?=
 =?utf-8?B?Q1dmRHRlaVFpM2dYOUlrZTIxQ3IzbWRTZ29RUktuSjFrR3ZncGxsTDEzUFZQ?=
 =?utf-8?B?Sk1CZmZ2YmNieFllWlFpL3lFQ05Xa2lhd1RyNU5aTFc5aFlHOGJ5MU5WanVL?=
 =?utf-8?B?UkQ2d0VJNWhIMVhMVVE5YmFlY1NmN29uSUtGSUl6N3FrZEx1ZU1OalVPWHV2?=
 =?utf-8?B?K21Ta2dwd2VjNGVnbGwxRlNmR3NnY0dtUDhZUXJGL3R6YWNRNU5aL3RWNkpu?=
 =?utf-8?B?dmJ6Z213WnhMa0pqWVR2cVJCZWNldVZoTHpzcTI2clVIMnVtZ0N4dEZoOG5K?=
 =?utf-8?Q?kCfNPdbSh9u1HJ+EmZLk8ZRpOzqrQ/4Qbh+WLdl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS84OXF1ZjRIRHB3LzdRU1A3VllVL1RFR3FhUGVYaFdXMUZrbXdPclphQmpY?=
 =?utf-8?B?MGNIenNTYk1yUlhwWFk2ajNrRFo2MVlFcFlzcmZXUTRJRXZETHVpRGtnTE8x?=
 =?utf-8?B?NUY1M2k0d2VaOUN0YUFtemZUc3NhN0V6LytaVitNRGJmSG1zSDBCMlBRMlRN?=
 =?utf-8?B?d2tqQm9GSW5haHBuNHAyQWJweEtXZ3lHSVArUE16cVdIdWZId1ZoSmN5SEdI?=
 =?utf-8?B?MWEwWklTNVFNams1R1c2Y014dFVIemJrUnYyd2pEVldpV0hyQ3pGaGVwWmVQ?=
 =?utf-8?B?VEJvemRzb0U2V2E3Q1IxOUg4eGcrYzVRVXgzbVlUd2IvaHJicjZpZW1scGYz?=
 =?utf-8?B?YmtjblNObm1RVzhhc0hlNXlrZEhGU3l5WjZkNFIwdnZ0NVJ5UGhSTDRxTURZ?=
 =?utf-8?B?dnFGVElKcmMwVElIRzBsajRkQUVXZ2k0WEVoNzloZzN3MVkvMGRzUlhOTU9q?=
 =?utf-8?B?SVBuVWJzMFhBT1ZTUWczRjZoUkFzeGRIMFJwV3FaaG5RRmVwYWdsZDVMbDlX?=
 =?utf-8?B?ZWFFWTNMZDlWRG83Y1hieVlPcWs3ZmMyWnhRVFFVc2h6Ty9FOEZYY25QUkpL?=
 =?utf-8?B?MnV4ZFJyMDQ5ZERMOTRKNFlkSVhDVEFKMmtOYzgwTmZPbWlaZVNEUFF1R2ty?=
 =?utf-8?B?cWhZaEgxOFpIbXhKOGVweWR5KzkrSkxhV0NiUTNWUWp3dGRDZm5mdHBrMzNC?=
 =?utf-8?B?ZUc5UHdRUFdEMDBERmdUSVZxMERXd1lRYnpLbjg0Wnh4OGlEbUlOaEN6d3dS?=
 =?utf-8?B?Y05vUlRhZzNkaTFuMllRdmtRRHNPUnZZY2xGYWFpQnI5VDRmb053WnJydC9Y?=
 =?utf-8?B?V1M3dzJzZGEzWTBwRTNSMkl3VHZXcVNjclkxTjRvTzgra3RwQ3VLRVpNK3pu?=
 =?utf-8?B?UVlhdy9MTjFFd0NUVXoxVWY0SnU0TklQWFo0cjZPRFNqS1Bqb010ZFAydnBG?=
 =?utf-8?B?QkM4MitIclE3dUdwSCtueVJSdWtxQlJQTmVaYU1UR0xwbXkzNGJPQnZlTFpQ?=
 =?utf-8?B?Q3ArZXpiSlhyaE8xUzZObUh2UG9DMlJ2K3NiMmRISWJxcjJiRnJTdldKWVNJ?=
 =?utf-8?B?T1NOU0FUY0RGSHR1UG9pRFU0YkJ5QlA2TlJNOGpveXBvWE14cFJWQkUwUm1K?=
 =?utf-8?B?VWd6NWFsUURYamdXNmI4OXZZWnhkQUh4UGl5U0owaFVvSUt2MTM4VURocDFN?=
 =?utf-8?B?YXlDbGozeko4dWxLaHd4aHZGb3lTUzI0bE9SSmlHc0lsMjRSWitJZGl2K3Ri?=
 =?utf-8?B?cEVCem9uc0tqTURjdHZhV05GQ2pia2w5SzBZcDA1aDRjenUxKzR1b20yR1I2?=
 =?utf-8?B?Qm9sQno3dlBVMzZCTjRHZUdGYTZUT2dOQytLVGhKOGs0VjJETHhaZVdTVnUx?=
 =?utf-8?B?SDhGZVluNWlWdU5YMG9HM09mb2dmdmFXL1lFTUhvK2tQR2Zwb3h3dGdLaVFn?=
 =?utf-8?B?THplMStmM0RiUXFJTnJKczNhOTd0Rm1YQWJZcndoMmkySUt6WGlRWjJJR0hx?=
 =?utf-8?B?Q0lBQ01mdDNCdGVTZFJMV0FRLzd6LzMvRzNqVWRaem84cERuS2g0c1dMWlVX?=
 =?utf-8?B?WUdzUngxVjluSTIyREdRYUJNQjBjOWRVSy9wbE1Ra2JLNzZzSWJiNmFqZW56?=
 =?utf-8?B?N2s3K3QrdzFhMGZUL2VnOEQxZlFIWUdWN2lrV05OK1RtOERmSHBkcFBHNUNR?=
 =?utf-8?B?eUFwTnFVOVRSRDJQbms5bUNqVHdWQ2xYbDl2Qk1zM0ozVS9UUWtmR0Z2dGJm?=
 =?utf-8?B?S2NMN1VDRkRNM2xJelpENit3MGdCWHgxQTRRSnJPclB1RmtJMnJGOGJzbzg2?=
 =?utf-8?B?Y2dvSnJJM0w3ZUtLa2VTU0lrdnA0ZDdYODBSN2c5UnRhTG43M3lMeU9lN0c2?=
 =?utf-8?B?MHc4L1U1UUpFWXowUUdNanlsU096M0V4d1RVRlZnWlZjajNaYXdqSExWRTFM?=
 =?utf-8?B?UUVNelVyMkhqMytMcDV6L1BMcWNQSmJjb1R3SklUdlpuYU9EVUVra0lDVHRJ?=
 =?utf-8?B?cnBUcUZld0xTTjdDL09vMmhrd0trNGNPd2hBTmxBMjBzdzFxeFoxcVlrVlhr?=
 =?utf-8?B?b1B0TWYxWUNPWDFxQzZScmFrMVBGbXhZVE14T0VFOEFYVCthVTlzUVF6eTIw?=
 =?utf-8?Q?EGNm2GdjgEqYOCV/+zpTpvHjN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7251f3b-185f-44d8-2bb5-08dcf22d7b61
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:07:14.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Trrgi36OKatkLiMn4BFjr37lfBkHnIgcAScCfJblR6TMSRwgDrAbHPQ2c/27Xg2/iEjD4U85w47KMA/t1LheVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com

On 10/21/2024 4:31 PM, Luck, Tony wrote:

> Diamond Rapids is in Family 19, not 0x19.  I was unsure in <asm/intel-family.h>
> to use decimal or hex for family (since only 5 & 6 are used there, and they are
> same in both bases). I picked decimal to avoid 0x prefixes everywhere.
> 

Got it. In intel-family.h it probably doesn't matter. But across x86 the
family checks seem to be a mix of decimal and hexadecimal  with maybe
more inclination towards hex.


> It appears that constant TSC started out model specific, but later
> got a proper enumeration bit in CPUID.
> 

Ah! Makes sense.

> -Tony
> 
> 


