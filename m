Return-Path: <linux-edac+bounces-3289-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DDA554D3
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 19:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA16B3B2C31
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DBC25B684;
	Thu,  6 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CTVCuDN/"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021139.outbound.protection.outlook.com [52.101.62.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCB27814A;
	Thu,  6 Mar 2025 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285110; cv=fail; b=JVeRHGLNCCeixUCETqVaCiHQEwDoJojjWHxv073fWTu98n7YQSlk59Syuuc6rhMwT43pQp+Qn5s2mJRVBrx/kw+6Y9W9VShfpbR1QjnchWoQQiwKeeaCXKFp9p4hkm7OOU2g3l3Yib/d5N8o3oi6+0wIrYxoRLUfPkSpkCSKX8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285110; c=relaxed/simple;
	bh=ygwF7x562Z60R+jyqVux4v0Y1DcTWWUG7jx9rvlnO/w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXb6MkXzuR04V+EZtwm477qVitNoEBDJEc2R+CN7q+dahvqAa2ZY1FsDMfK3PQtviR2XoJZZkjOrtwQ1ymkJXim+uxp+056rvzgbRfqY47WXpM5n5EEaV0XLP3gNNVsGW6Rt1ienWBwHbyxLiBVKxp7A9X2nNL/80GI7fzif1Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CTVCuDN/; arc=fail smtp.client-ip=52.101.62.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHwqfsRiHxPFsGIdmw2dpzpUokTWynnyIbGysMXOAapOlxvLMWxqf8qH++50KnKNbaoWs3VY8DCgkJzQydyfw8rBiJv927d+SAIfBNbtHDs1aJDVHNdcpFPHBUW2RprVFc/4tMIiXD2H6QfDV7H2Q2panAgFLZOfEQ+pLTMuKirR96jOJJrhIjUbXeult5GAlqCLRiy3B2e1sRllXstond27CPqRjYLLsik+/D1vQNk7Pb1qIIsbRdiqEHMlpfc3DNtGremO3MBrBFrFJpDY76Q75WBWEXZEAC8jFBp6sh6zSaJM26CqdSTA7b1W6LvulJnjZPHevyK7oKEvHNiM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha+RWfrFW4SKZlVj0cAbEmjeDJmwxM7hMpqylGhLR2Y=;
 b=kvyE/abqhHvGFosXQhplrVUDbjJfpDNqcc9wsvkKOHZeRdcjc8FMswc7eKE8iIonTxa6PyhMBSCjhQBm9B9zUxnkxF/B9DzKxdzj5VyRakbME2PSHtUm0Q0qu8pAH7cgj+BYDMSgHX88u2lCIZEBp35MeGGuyx8fX4nlrqBe0kz57K4CFA4ZlMrpzHB/IbJ0BYmhWQ8pO7XuQdf/75mcJoKoEPRp9nIAWjW4f0dzx3obgKS+7cywiILUnMKV3LSG28jV77RaC3HyX2/J20NkOA05VsuDDU4oYYfxnaUvfDL8qEtqf8Z9R1oQitpr5LX1xuFxc3wXVEkRT6E08qFRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha+RWfrFW4SKZlVj0cAbEmjeDJmwxM7hMpqylGhLR2Y=;
 b=CTVCuDN/eWtI7SnepZuR184X2yqdJprhmsO6qcuMsv464l0AaOIyydYctn5H8EV3qBBoojyCfc/7nZiSpPu2tNUdkfcFcLm+uAADoX1eVzvIpW4WQK9GoniRddvl6CEAcK3Tf4kHKdoTj8+2rIb5HmYewDUVpvc5dHmHUcDblec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 LV2PR01MB7600.prod.exchangelabs.com (2603:10b6:408:17b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 18:18:24 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:18:23 +0000
Message-ID: <6d8e89d4-e0b8-4e89-8a18-6f9d4f2989ee@os.amperecomputing.com>
Date: Thu, 6 Mar 2025 10:18:19 -0800
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
 rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250212143654.1893-1-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250212143654.1893-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:303:b9::27) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|LV2PR01MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbc321e-9adc-42e9-7d20-08dd5cdb480b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFvanZ4UzIzRng5UzBCLzdnTUR2am9IRWEzMUdNT3AwZDFyYytQUnV0L2xF?=
 =?utf-8?B?aExSbThtNVNoUk03Mkd5SGhKSU56Z3NpalhONjZQWWR6UGljTVVtMnFtQk1G?=
 =?utf-8?B?cFBPWU1JRCtidVUycWs3cDNuWVhYRjRhc3FaNVpKSklpYi9SQXl0eDg5M0Vj?=
 =?utf-8?B?aEtTNnlDUDBhWFIydjRYYm8zbzY3Y1ZYcmZmMVpTUElDZnMveDVQdW9GamNi?=
 =?utf-8?B?dStQd2t6VTh6NkY2S1RjUENtd0VCRkxmQ3JPbVFaMUJ0eDVkYWlmcDZndU5Q?=
 =?utf-8?B?ZTd2ZUIrVXJ0MjFhRkU0SnlyWi9wbHcxSitUWEhDUHdFOU10T3JkbDZLQnd0?=
 =?utf-8?B?Y0JSeXZiSk1selNzZ1RBSjF5eXpwamtPdWpmdVJJQ0dYbWFmSy9PV0h6cWRu?=
 =?utf-8?B?WWxsTmtUQ3hZOC9JczhBdkNnbzJWcXJ1a1lJMEt0WmVDNkcwRVFBMnpXQUt1?=
 =?utf-8?B?TEJHK0ppQXhHL0w4a2lDaW4rM3pSSk5RNjYvamxQaDBLcklXSE5DYW9qaElk?=
 =?utf-8?B?M0VsR3EwdzR2RDdtWUl5TFg0VGwvMVNxS0NsTVpWSThZZm1oNEp4b3VONUMz?=
 =?utf-8?B?bk1iWVk3SjFWbm5zSldkbG91VzY0dnVvUGNWR3B2NEVUMGRJVEpiZjlJRVFI?=
 =?utf-8?B?YnFFNGdyNSt5eGFiZytqb0U2Z1pTSVU4Z1g1RHZ1WklMLy9va0lkYWNRZXRm?=
 =?utf-8?B?ZGd0VWxUaVRwVG8yZGZEU1hPQWhTRm1ENVNxK0dJdUd0TkhHNFBITUdhbmpl?=
 =?utf-8?B?cnYwWDRmTEVSOVE3M0QxUFlGOW1MQ2lHSVhqdnE5ZnpqNGJyR01BSVF3NTBl?=
 =?utf-8?B?L3FNaHJPczVKaW9vcHcveXVZaUdpQ2lXYWYxQW5ydG9VZ0dLeUpGdVhnWER6?=
 =?utf-8?B?aGxJK3hKT0NLaHNUR1FmNlF4Y0hnTnZTY2lFcm9qVzFHdkRaRXdQWCtHaDhG?=
 =?utf-8?B?YjNzVjlRT1NkYWplS0JzMVVRQVNER2EvL2dFamEwWFNHVmphUElFSWtYRHJa?=
 =?utf-8?B?ckg0Vit2MWhGem90emozL1gyTjNhenNPajM0S00ycjh1Z2F5Mi9jNWQrSXln?=
 =?utf-8?B?SjdHV3V6dGVYb21YQll4cWlNeDBBd0FEWVNUUDlhMlhoTUNpRGxRb2VlYTAr?=
 =?utf-8?B?Q0wxcGo1ZitoRVc2a1J3L0N4Ky9yd1N5c3pTMzNXRnFsWkNnVkY1TFpueEFH?=
 =?utf-8?B?Z0pvN0RONFVrWlhGbm1MdDRpZnRXRS9SNFhwcFpyQkdKNk9mVG8zY1Yxby9C?=
 =?utf-8?B?QURmT2VtRVpTd1JVcytTbUhza3hwdXFIQ3ZXNnhSblBzQ3FFZ2ZDYUo2TDQ0?=
 =?utf-8?B?VGlnT0hNYW01U2lITkFQK1VPT0JUS0oxOThFY2FGekh6QkpBNVF2VVdncU0w?=
 =?utf-8?B?Y2g2ODVxZ1pBUmovZGFSVUtvM2htYTI0bFRZUEJxOER6SlFzL3dhVXJlYXBB?=
 =?utf-8?B?VlVheFJlVEgvV0cyZEpBQURTUThHUlZsUlJuOHRrM2ZNdUszYkZEL2Z5bzRR?=
 =?utf-8?B?bm0vV3BGeEh5eTJCOWkxelRwb0lUUUdIOG5XbTVjYzB6dnhvWFMxcFEzcTFS?=
 =?utf-8?B?d0w3ZktxdXQrMXo2RHIzcHlGbWY1c2FiWWdKY0VPakdtMmNTbTBqMjkvdXNv?=
 =?utf-8?B?MG1LLy94Wmw2Snl6T2U4cWM2N3luam1NMk1XV3VxUmRXV0VvakZzNHVacnFW?=
 =?utf-8?B?WllZczYweG5qRXd6cDluVWIxU2o0NXZKam9YRXRsUUNWd1VvQWJXMHErVmU3?=
 =?utf-8?B?dEhMbHphUFdvYnFGVkpYRHB6TFNIWTdKdFhoSi9vT2JOOTMwT3orYmdHcDJG?=
 =?utf-8?B?UEdKTnhTclRGWVZHVjV1VWdYcW5BQ1Jod1NTUyt4YzVvOG1uZnpqejI1SnlI?=
 =?utf-8?B?aTJNOHdOSHFMUkEyZWljVWdDK0ZLUUhHMTVteHpyRXl1czlCSVZpUTROMFcx?=
 =?utf-8?Q?hk+3QE2SDrMUNOfqE0W0Irxph3aJSckY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkQ4eEIwQlhnUE5YQmVKTzh4Vi8xU1N1VVM2WWdSTmp3cnZBOE9nZTdmV2lJ?=
 =?utf-8?B?cWZjN0VXc1NOUjYzWitGcWl3RWFIbzY5SW1QTVVrRTc0UUp0Wk5LZnVxMjVQ?=
 =?utf-8?B?VUZ5WmlWYTZLTU9uZDQrdGw5Z1NzdkZYSkNDQzNxK1ZiM0NBcUtPVWhPK1kx?=
 =?utf-8?B?VytpNXhuV0g5VHdVWTlZYjB5bzZFMG5senQ2VlphekxWNGpiTldNcmlPMGJC?=
 =?utf-8?B?R3ZJZ0VmeVdxYXo5aHE5NnRrUzBubW9aaU9IOUdMbjMxeHNYQ0E5ckxNbjMv?=
 =?utf-8?B?MHdJakVUYXNkQmU4WXB3U3VrbVRRb0VpVFYyQURqMFpCeTRJcTYxU1ZQRDdG?=
 =?utf-8?B?bThndTZzNkorbjdEZ25VVElEK2FNREJaRHFqMDFHdmdrQnJYTlhDcyt2enF3?=
 =?utf-8?B?ZmV0ZFp1OS9mRjRWWDZNTVVZRi90Wm9XSnBRbm1wS0tDZWVhWDNBNjlpeXJ0?=
 =?utf-8?B?VUp2MlVYNkNCT2Vic05zNFRzODUrWG9DTFAzTFhTNStnUnJjMGRrWS9BaFpC?=
 =?utf-8?B?aU5Sdll3dTBPWDBYbnlwMDRXMUpmY1hKOUQ3NklvSkxIY0ZyZlBPUDhtQ1hH?=
 =?utf-8?B?dEdlUHNsVVI5UzhyODR4eVQ3eTRQOEIzdmppVFd3QStkN3c0anBWVys1eVFa?=
 =?utf-8?B?VzRnUldEcFdEelJ6b1AxWkVKaUJtN3FqZ3hwZHJhaXp6RHRxZmptZ0krMnZJ?=
 =?utf-8?B?K0k3WEhVcHkzZ2tzRjFSSkU4bldEYmdSZEZJcEJVbG8wcVlud0tHWWpFNFZ2?=
 =?utf-8?B?MnpkeFU1b1VCUFFrdkU5M2NsWEszTWU0c0ViNzFUNlkzKzV4Y0FOVlA3N1d3?=
 =?utf-8?B?SVVFbnZHa2dLMCtrMjlhT3hTVWJ2MUdtMHU2MnplbVVvU3RGalhGc0liWWJG?=
 =?utf-8?B?bmN6QlFEeUFEcy91TG9RTHZMLytITUtXbmRrS2pPc0MydGtTUFV3YWlFTTNa?=
 =?utf-8?B?UmI1amhuNXNKTytIR05KZ0dTZlAvYm1JcTVzc2hhTXRISzZmRWRVRUpGRVB1?=
 =?utf-8?B?cWQxa3hKOXBxUjdNN3doaUVBUFMxZWN3QlVCQ1A4QXdoUTgraFdDNEJ2blpU?=
 =?utf-8?B?bXdoQkluOGJ6c3JBeDhETnFHMGxCVTFseFNyZThLSGk4VFEzbzI3YU15TmZt?=
 =?utf-8?B?Z3RNbkhJRHU4RWJsRllYVmsxYkI1SlZWZEwvYWljZWh1TVVkN29aQVpWQlJW?=
 =?utf-8?B?WUZici9hZHZmSStreWFBZG9OelF3NlBlYytMZGpLNFRSMmRwTExZOERmNnVl?=
 =?utf-8?B?NWdOaFBIdHlPWFE2dzBoRVh1TmdST2J6bnphODdPdGlCQmd2Q0NwcEJaUFRl?=
 =?utf-8?B?ZGw5Y01zNWYvUlkvTWpETXF6dm9GaHN6eVJFVllVdlYrN2pEU3N1bjJHTmgr?=
 =?utf-8?B?SW91YWJNcmlBbmNydFlkelJBZzdBckNVQ2xvWXF4OXVIY1o4SkpNUmF3WDlz?=
 =?utf-8?B?YWpaR0dkczA5U3Jxa2dtSTNOelFxMmo3STRzSkNLK296YWRROTFJYVJ3QmYr?=
 =?utf-8?B?S1Y5WnA3anRLZkptTUVyK1IvTGZUQ0trQURwWExWQkJka2pFVnpOZ3Vyc2lk?=
 =?utf-8?B?aFNScC9lUGhKbERmVG43dTkyOGljTTduMmkwU01OM1ZKbGZGUVA3aG5tdmpC?=
 =?utf-8?B?VFMrU2hqdVJsSmRUVzlqRVBxSk9mdDNvTlZyb0VNVnoxc2NFOWxnbFBoRkRI?=
 =?utf-8?B?MXoycm9iVGw4c0xhZXhFODkxNnUxZE1SQ3NPV0FrbVZSSVovUWw4cEszRSty?=
 =?utf-8?B?ei8zOXk0azZpaW53UkhlMDJhUkR2WXBzbDlTVC9aeTZsNGtobWhyejI5cUR1?=
 =?utf-8?B?MUozMk02LzEvZys4WXQ5UFZtNXVNWGFmVEkyWXFwb043TmNSdThabnhxUFRL?=
 =?utf-8?B?dUxhdzcxMDNOTEJveDJIUkt0eTJkQ2ZyUjVOK296bkJxTlZFR2crYUNYcEZw?=
 =?utf-8?B?TWd6bzZUUjlSNW5haFdKZjRmU0lJMEpCUXZ3UEtyOFV1QmxWNjY1Zk4wWXJv?=
 =?utf-8?B?dTZkdTFPejhEU2tiMDF5OUhWRmkybUtsYjRGTVgzM2o4NG5WazBmeW83b29S?=
 =?utf-8?B?aG1wSFJvUXVjd3hVYS9ZMWFkY3dqbFlnVDJlTStWMXhQUWxRby91NTlHT3dt?=
 =?utf-8?B?V00rS3dnL3JYc21qV2ZSdWNLY1pVS2xaQlIrYlB6Z1lqa3FRNWQvNUdPVzhR?=
 =?utf-8?Q?IhknyFVZ7XXsA5gaMrh8Saw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbc321e-9adc-42e9-7d20-08dd5cdb480b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:18:23.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v6RC8+FtqfOFy5uAz7ONUTRqeVSmunfVm/8QHyfuugiEdX87spkCHPGx5Ac4ibSO2puyjR+OLKJy++4UwcMg3K9Ov/vUnCVY8CqYJ3J2iucmXp89iLrl8gsngKW4d3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7600

>  +--------------+-----------+-----------+-----------+-----------+
>  |              |           |           |           |           |
>  | Setting      | Supported | Supported | No        | No        |
>  | scrub rate   |           |           |           |           |
>  |              |           |           |           |           |
>  +--------------+-----------+-----------+-----------+-----------+
>  |              |           |           |           |           |
>  | Unit for     | Not       | in hours  | No        | No        |
>  | scrub rate   | Defined   |           |           |           |
>  |              |           |           |           |           |

It is our opinion that the Unit for scrub rate should be unit agnostic
(implementation defined), and definitely not specified in Hours. We believe that
the spirit of the RAS2 scrub rate was intended to be implementation defined.

It takes our hardware less than a few seconds to scrub a ton of memory.

