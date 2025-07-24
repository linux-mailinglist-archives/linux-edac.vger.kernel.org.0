Return-Path: <linux-edac+bounces-4431-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A5DB11117
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52CD1CE541E
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60F2ECE80;
	Thu, 24 Jul 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nbks5lAg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369212EBDD5;
	Thu, 24 Jul 2025 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382556; cv=fail; b=Hw1Tz28qcgkok8CfcToXvbpnZe3eyKz8oyUwcu8F0LJyQgZaMWCVhcUuGhKxmF6ZxBRbplCtqghFYyLEGHvJs6sR4GpDosiDANAtuLuy5+Pv/z8P7tlum1aPmJxAo/AeNjlsY3iFDn8JmA2Fe6Y0VNyUr64qFvpU6quC9RczAWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382556; c=relaxed/simple;
	bh=dhmndhFuoeVQa8ZKPa6EYGmuo4PG/eJtARGa8Mz1zEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VcTyhJRyrmUFXTBrfx19RrYoc5xrBpdGduvx5QymZf+dffHvyhgVSBSZEVPMwtb2ikRQZHY4+mUjaM9ElkZvY8CZVBFAsbr5TYSJ8UliLvEMPn3+boe+bAvUXGUfpnd//CWz9s4QFoB1B8bt2DD52XNAIDlNbgpNF1/Aqt30ptk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nbks5lAg; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjGPn9x3NBe+Q62b8vdVU/TnSo/Lj9IbLY1zWObyRwcnEFnFjH7YtOkJ60DbJv0v8+V7y9H7lESiVTcuOWXclLt0FnPkBpbqmzRr0SMn036XGXddE1PMAR1c1E7V6BMvuNre5mgiMWbJls/RH7Peh4xx8m29ZzUxEqfkrXtguwMFx1Y5QxqiKPHDpFQG+e+orBCih7aF0NPiDM1mPzD+ODKjE3C1kKBU3tduzlxFzRa6kjibzT126KDv+oCphKE8qayawn+NYdcBo2/1+NXXLc4vGsbcIKa81zXlnm3LEPgRHBDdUVuaSMP0vNWeLojCrzB1GNwgpJJVECk5E1hBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQDpQKCbU6hEtAyLAaQzkTYY6ASU0TQyYEq3lhfqMDg=;
 b=y+j77nDTq+OOUFlal6ZWDY4THae3IC5UjZzGiJvinb4MTuU5WnJMV81V2dgDsl2e9HtkxLZJwP6vpVfU51IeJbWqISwpUcCgdZdi7Z/gTMkybO70GpEGNM/kjpm84cS8MO1Re201zdyQMUQVeR++JWsfaKp9gIrPBraW+QCubDz75u4SXZeNeAWFmBN7+TUOy6KIIzniH24+HM81OWe8Rd9CqURahKsAOQY++207BjLoS6LX22kyThrDLUVcok8U9kmmsfCH8SbNU2/mqI7SzvOMHqJB7I2KCXwwDTgYd4/AMsQf5yuSlzWwES7zpPslyMvWeGL3wuL7CorjtU0dNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQDpQKCbU6hEtAyLAaQzkTYY6ASU0TQyYEq3lhfqMDg=;
 b=Nbks5lAgM8iZfvu6vK+w5tqTHHK/7ZHBAzeEci3wrWBnbx3fY6K3bEZdvwAX8uyeN2gwTa5c+3pmdNN5BJklYZ/hie3yKoF/wSQHfX7xUslPXCVkm1z//tYBYEDFU2KhombXAMisbGlVr+RiEhtFyNv34uU8i3PgDSI31gC2UeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 24 Jul
 2025 18:42:32 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 18:42:31 +0000
Message-ID: <c64a1962-0c6c-4685-af60-78df6b39d6bd@amd.com>
Date: Thu, 24 Jul 2025 13:42:30 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] EDAC/amd64: Add support for AMD family 1Ah-based newer models
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20250722192855.3108575-1-avadhut.naik@amd.com>
 <20250724132430.GA985@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250724132430.GA985@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:806:d0::20) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: d01bef94-2112-4b37-c9b8-08ddcae1d8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkJ0VDBXZFk5U3I2M3hkbjd2cm04Vm0xd01lajltSXZhbUFaaHFrZ3lSVTBr?=
 =?utf-8?B?eVRLQ3ZHc1lkajVHZU5zY2JYd3kvbTFWK2R1MFM4dGVHVFhNYjc1cDZjUkky?=
 =?utf-8?B?RUJUMG9XY0dlRkMvbVZWMjRoTEJSUTUyNDcwVGRIbkY2Umt5ZklBM2I0bDFz?=
 =?utf-8?B?MHFpZmJZTEk0K3lRTVBRMGc1UlUxVUxJY3o4WUhnM1pvc0NrQmlPZ3FYT0FG?=
 =?utf-8?B?UlhBaDJIMVVqQjVDdUp2dWdHalN5WXhWb3ZybWtwVWlTcm45WkdEUEdzNzR0?=
 =?utf-8?B?R25BVzVMTlQ5TVViM2xDUHIyQ2ozaU9FdlRTTWU4MUhlYVRTN2ZLUUtVZy9l?=
 =?utf-8?B?T2ltZlIwWU1xTmxobG1LT0xaU3E5MUFwTWQrTHBuQy9YNlRoOTRKUWxYN1Ny?=
 =?utf-8?B?VVVGcVZ6SkV3bmU2Z3UxWWZwTEZCamxMVnlyRmQzVG5BazdsbXdNS2I5RTNj?=
 =?utf-8?B?UFBFdTFDRE9LcUtIa083MVU1T212WXJMYVY4Q0N3V3RnYXorMHIybC9RNGFE?=
 =?utf-8?B?ZUtHb3d2TnpvdXlVcU44ZzRUZW9abm9Ia0lFV3ZUeC9OQjBBM0RWYXU4N05k?=
 =?utf-8?B?dFNPcFZxbWUyV2s2YmtHdk15Y1h1VExJODgvZmpsaDVnbzZ2blVuRE0wOEwr?=
 =?utf-8?B?bWFmczR5THl2OHF5aUtWRkRneVMrNllrU3RtaDNIaEU5M2lDcU90WWtLeCtO?=
 =?utf-8?B?elF5MXV3TmJQcUJocEdOdjI1NEM5ZE15aUtEajhTUm5CRXNuclNLZ1RaOGs3?=
 =?utf-8?B?eHBNbm5XeVd5WjlQbHRnVUF1TUFtdXAwdGs4ZzFqQW5NRnpCRldUbFBkZXI3?=
 =?utf-8?B?d1BMdlMxMXRsY0Q1WE4xem9EcVM3dVg4OWxxSWZTWW1aRGxsdXJrUXI1WTBo?=
 =?utf-8?B?OWNlSWh3RXF0Q2JQdlpQSUpxajJncitPSTRnVHN3TFpMQmV5YWNjNGZJSy9p?=
 =?utf-8?B?Mk55YVpCSWdKUHFHNWZJVlFPOVlmc3RDdTZacDc5bE9XVWR1d3NwMWlpbFp1?=
 =?utf-8?B?NTh5ZDV1bllXUk5zMk52RXVUZGRqajh5RU9ESXVWVWtMUXVBd1N0aTRQb1hI?=
 =?utf-8?B?ekxCczFHN1hmaXNsUXFBUmpadXlGVGFLUlc0NVJ2TWtORXVrT2Y4YjJJbjdr?=
 =?utf-8?B?Y0lLRkJOVHZ2RVJnTktpejhzK25qdytZQmtMN1JZK3E5L3ZKTkx4dWtkMW1Y?=
 =?utf-8?B?dW5sdm5IZHVjeHlmeXAxb0ordi9zdEdZR01lN0NPL0NySENFcmw5NWZmblAw?=
 =?utf-8?B?YWVrcGhEcHVRWWdvWFJQOWkxT05icHJadUMyYXBRTjd0S0dsYlhrNTFtSERB?=
 =?utf-8?B?Wmlyc01lMktGYnB0SHR3RWp6REQyc3NISENvREh6cDI0aWpoWjBBRHordUFW?=
 =?utf-8?B?bEpTREFyVjE3WnQxdU1aZW91VkU4Qm1ab0lDU0o0THpicmxxMEl2ZVhaa2U5?=
 =?utf-8?B?SkJmOXlSb2RySTE2M1N2TlVXeG02TmZ4bXp6R1dsOEREVzR6cGpFS0FJYXRl?=
 =?utf-8?B?ZUpQTmFLRVZkcGhHNUtEd2g5TndFeW43OEtIZFpSOFJsSDhIWW0rL1h2b2R5?=
 =?utf-8?B?VHZBL09leFlldk5vTVhGWTZCU043a1RkUHM4Y2NOYzVTTUxGdzZ1L2pvQlI2?=
 =?utf-8?B?aUdDRG9ZSEJ4Zkp3TzdTYlZKT3lDZjduUVhlS0lPdVE4OWtOVmE5S29WZ3h6?=
 =?utf-8?B?UUdmTTRTOGNSVlFuWEJBTXdsMFJZRWlvbnZ1L1c1eTk3WXhxSURhdm9STVkw?=
 =?utf-8?B?KzBSZEdEUTFNc0RaRjlENWh2eWtjSmtZVy9iTXVON0lMM0MyWGtKNlJ0bUVQ?=
 =?utf-8?B?cTI5aE93dkRLcXErVnNneXdnSGFwZG56OHJxY05ScGZuKzZjRmxZUU1KRy9L?=
 =?utf-8?B?RXoxTTZmeTE2eVZMQndJdWVYc3hOUjQwclRjYzdKdDNKY0N5UVIxVUJkTno4?=
 =?utf-8?Q?pDVOaLkR4nk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGJTZUVWNFFaaFRyNU1wMERJWUE4elQxaDBxd0hrSDZ5KzNMUm5HU0FBM0hF?=
 =?utf-8?B?VVZwSDFIYlJjQkxVRnlNaGthTkdGL08xSGRUNUNVOVp4M2lObEdidURiN2NW?=
 =?utf-8?B?TnFVUXMvUCtiQmRRVHZNdHJoQW1vUzlGam91cSt2MHJZMkNuU2J0WDBpZGY1?=
 =?utf-8?B?VDZNWDBrdjVrdWVsR3A0b01oSWFxWjRSd21kRnBtY3g0WkNsZXVkZkNldzBP?=
 =?utf-8?B?RXZsMjJxR1pVNVVlRlZPNFJkYi9scEhSNkhNYS9ubUpieU4zTDcrL3YyUEdm?=
 =?utf-8?B?VTdEQTVpU25ISVZJb3ZEbEUvci9hc01DalpETDRKZVRyR1V3dWlNWVM1S1RL?=
 =?utf-8?B?djd0a3plQW8zSlBCRFJNM1lVRmFrOFRnSXhoYkJCZXN3S3JUQUpCUXVrdkR6?=
 =?utf-8?B?WldLRVNNbTNuZ2ZjZDZqeE00bG9Zb1l6cjdGcnZlY3UrYk52cVpra081cDVh?=
 =?utf-8?B?MG92R1dSRy9FVlA5RFc4S3NMMDZCWEo2WENYSGJZVHhDVEFpd3lQSVAxZUpO?=
 =?utf-8?B?QUN6dEhpUWJ6VkFIelhUdVd2bFllSzhRR3M4RUthVWVEUHBQR2VVQlZodk5T?=
 =?utf-8?B?OXhPVXg2UUdRMk5DZDRhaXhkU1lFb1FIOGVLajVFM3A1Y0xmYmIrVEhvb3FR?=
 =?utf-8?B?cTZGTTVjdjBocU9JTzkwWDlHcjYyR2luUHhsWmtTQkV2MkV5RFQyTi9ad3JC?=
 =?utf-8?B?Y0RHZ2FCZFBFbHhIbVBBcHhoTUNGRTNLM1FwV095d1JGbEpIeE9kTjhVbUxN?=
 =?utf-8?B?QWtGTG9QQVpyT3dDcUtTbllMQWpSdjVFbmYxNXZ5QUlwanhJbm5CenA5S3pE?=
 =?utf-8?B?UlVaU3MzV3pMUDhlck44QzVlUEdiYlZJTXQwZk5kK3Z1TE1KRzRGODZFaVVa?=
 =?utf-8?B?K2FyZEtGMFpiZWZxdldYbUV5R1dlcE9VNHgwOXpsaDJsOTRFUktQaEZMeGZU?=
 =?utf-8?B?MVlxdmRRc0llQXZsV3hxd3I5bU1UbDlnZ0ViNWNLbUhIaUpIR24rZEl4Y3o0?=
 =?utf-8?B?VnVLY2tRM1JTSjVSODlETzBwb05XMDU0R0dQRXMxc284NWs1MzY3RVFZTXN2?=
 =?utf-8?B?KzBUcU4vKzBoUU0wTVliaTh0Z2g4b1pHU2szNkdLdmE2UDZjVERrYkRxdUk2?=
 =?utf-8?B?TGxtTis3Z0thcWxIRmdPRUVVTkxyYmNPWjN1eUNIenY4TzJJSU01MlZtQUlN?=
 =?utf-8?B?aFZTYlFYTUgxbHZybm1oYS9DSWVzR1hqdW5MaEk4NmV4eXp4N01CdmJwaDdT?=
 =?utf-8?B?ZllUV3g5c1N6Nm81SnpBTnFQR1hDektwekF6UkNialo4cGd0WGlBcHg5c1p4?=
 =?utf-8?B?bE9IL3lEU1BHZzdYaktqTE1wTXFZZFAzM0RlTUxLalROaXhqY2ZvUGtudDhT?=
 =?utf-8?B?U3ZvZnpSa1hTd0piYXhMU3g3SlA3K2dBdi82eHZWRWhGbGJBamU5NVdsOTZD?=
 =?utf-8?B?VTNPWjEwMmtyTENUWmhmMGYxb1NDMnNMVU05L0lvVDA5N2hwaGZ2b2tnblhk?=
 =?utf-8?B?Z3U1WnZGb2tvVUdNYXloRTEwU3lMdnV6YjhDN3ZKeHlyWnJ4NzdtTUFHbVRW?=
 =?utf-8?B?NmkvQWxqd2tmQ0Fldm5KVG45WlgyWVExZkxYZ2tEYm9LdEY4Ujc0eThyTmhz?=
 =?utf-8?B?eXhLSHpPbU9ESER0RjhvV3lkUElDVzE3RVp5aHRyVS9EWXVIaEZSR0NlM3ZW?=
 =?utf-8?B?enpZQXY5ZHFpRnpheWpac1VXUjB4blV2QmNKUnNzV0M2cEV6RmtSM1A0UTgx?=
 =?utf-8?B?OU5vanJHd3hxdmlKUjlDRXRZRVVaYmFGTkVNdWlPdTBFNEtEbUlxT2g4MmFL?=
 =?utf-8?B?YVV1Q01pL21wd05qMWhjLysvTEtFZENFUE1NNkMyazBTVitEay92Z05QZzJW?=
 =?utf-8?B?ZXh0Q1gyVXdEZkZZbkVCOEY2OW50K2w1T1h3dlQwdnU3bnlEUTd1YU84NzZl?=
 =?utf-8?B?VWhSQXJYR25IcDhXK1pHeTF5NWl5TTlEbURBeXIzL3hUMkxtQ3lpVm1rQXpu?=
 =?utf-8?B?UWZPNEpRcTd2SWZ0RitnT1BvR05jWDhxZ3BGMGF2aDNLMjc2WWNvZ010ajMz?=
 =?utf-8?B?ZElhdFpiTUV2LzBRUmh6QUNEc2NXQWpjQ1Fyc1pWQ2lxMUlOMC9qU1pGRys4?=
 =?utf-8?Q?d4W7Kq4wptPq2S3zQFDWCyMs/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01bef94-2112-4b37-c9b8-08ddcae1d8fe
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 18:42:31.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVaBxUcbqq8PIz3fVdG7Jz3q40O+s31OTtdFU/O9xB5Uc7oW9AQJY1B/fweV1O+Cvw8/AYs0q9EYYG1rbEkacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934



On 7/24/2025 08:24, Yazen Ghannam wrote:
> On Tue, Jul 22, 2025 at 07:27:31PM +0000, Avadhut Naik wrote:
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
>> index 07f1e9dc1ca7..06ae6750ca14 100644
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
>> +			pvt->ctl_name			= "F1Ah_M90h";
>> +			pvt->max_mcs			= 8;
>> +			pvt->flags.zn_regs_v2	= 1;
>> +			break;
>> +		case 0xa0 ... 0xaf:
>> +			pvt->ctl_name			= "F1Ah_MA0h";
>> +			pvt->max_mcs			= 8;
>> +			pvt->flags.zn_regs_v2	= 1;
>> +			break;
>> +		case 0xc0 ... 0xc7:
>> +			pvt->ctl_name			= "F1Ah_MC0h";
>> +			pvt->max_mcs			= 16;
> 
> These last three groups have extra tabs. Please align them with the
> other lines.
> 

Yes, will do!
>> +			pvt->flags.zn_regs_v2	= 1;
>> +			break;
>>  		}
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
> The "legacy sysfs interface" needs an update too. I don't know if folks
> still actively use it, but it hasn't been totally removed yet.
> 
> See this commit as an example:
> 25836ce1df82 ("EDAC/mc_sysfs: Increase legacy channel support to 12")
> 

Okay. Will update the sysfs interface too!

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


