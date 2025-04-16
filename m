Return-Path: <linux-edac+bounces-3566-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0066A905F8
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 16:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9750B1700EA
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2081537A7;
	Wed, 16 Apr 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kXdauK0t"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0A1DB37B;
	Wed, 16 Apr 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812647; cv=fail; b=ok9PdnaXlBZUmDrwNOzzV48Xv5HPXIoVpPbhGqIpy7SfFdytRi6fuSWrkI2oiiX6U+DlaZCwyy5XjaOXzf4Vjuu9jsiB+HIFt01G+Qn0E/LYA8Q9Q6GCQHHWKQOJmiwbpUb5Zl7Gtq6jWMIsjkBTkcmHo+TG5NzwMhfuMp33jUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812647; c=relaxed/simple;
	bh=5Bq+QS+VciV45eiMdg+O4z2atQg04xnc+dyakjLKDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dFgpGIcP41vy3VexgR5t5DtFVWjO6UOUCk19Z/5k9X2bGCMFOMbLlL+xuuHFkx89oLmDb9WLsg8HzUn+NLtJD7WWoZyIUMPRUDQzzXCELQD6QraUoO823MOuRsE9CkeNb25nuJcW3RZ8cFA2wSEb+ciDiaFGfU5lP/yOEt22qQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kXdauK0t; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR4HUF1geczWbx7L9TO7P3NSG0QSN6v+VSYFUbOSLNkFQtautXUoCVNolRg+lVV/wssoAjG/LIVfy561BzHMSGHj0MoiMGwHwHoRfQQ09Ykno6T8I6LNuIg9zszWDjaJX/hKHPBYn5R+yrwCcepavX0AZ04oOcM2TjsIxY7kSRaNNok5Ox4VCcra/P5t6uLJbPpDE/O7r9oPtW4oD/VlPgRVXHVuUeuS7Lgla/qT5EsUbwucrCemtuhDbrBMid78cTb/PU9q7RmF8JiUuTul1XRmH22/K3UHjktS7RcmoMz8z/i8HLyZe7LESZLe392JvhxvPFOMKRg4PNUkH9HffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MfqvwEl4wkriCua32jhZJLKisJxHnCfSi5NCUen6eo=;
 b=QhagJ13ZlVzjucoisVWvv21jkXKcJ99rHpTwW5SKeGA6sN/PZDk5BuqrAJqrgpzuPJ/Qiwmm0PUcOsJfcl9OVFlZlRedVrLRH1Ik3DOKoHFt8ukC34g7XLi5l1x8HBF1cg9i+8r8FmS9EGsE4cd4uq0vgrftNKSBxXgQRM8AoVcrGWHOJ4klUsHh4+ODlnTFxVSCbnPvCCq8dxbl+zk8k8wVLGZDjxf//Br9t1jOAX7jUl3lRFYZBwDwzKg/H9T4Cq/ZsMRGayjMrWxrWG/pEzwdY7HphuneBw4Fg4WRNrDqagDjLY5uD2pQ88nJTV7rqtO9fXXscMjniJ2hsdQ7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MfqvwEl4wkriCua32jhZJLKisJxHnCfSi5NCUen6eo=;
 b=kXdauK0tghIynIII0RwH9og1/iQF+osIDQD3PUeIHlMsWLqUg3YGhl6gVjo351kYCaJ2thtG0p6eRcOokdo2xnMwA5BJ+d2diPOINIdIYEzPQqui1XcpMnWzoYbkKUlcPxTerzXh2Cz2VA2wAaUVuyh7XvhV+Te6f/NU8DeoUjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 14:10:42 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 14:10:41 +0000
Date: Wed, 16 Apr 2025 10:10:33 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>
Subject: Re: [PATCH v2] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
Message-ID: <20250416141033.GB918127@yaz-khff2.amd.com>
References: <20250415213150.755255-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415213150.755255-1-avadhut.naik@amd.com>
X-ClientProxiedBy: BN9PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:408:f9::19) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aefed6-e44d-4cfd-4a20-08dd7cf07899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVMxU0dRZWQ1MFJwekd3MXROdlQ3S0ZLL0gzNytJUkZuTzlmQy9LRnQ1RWFt?=
 =?utf-8?B?YW5MWk9TNk9TV0JiRlBqam9QMzI2SVpyYXM0WTNONDVyMkNEajdKWkxDamFX?=
 =?utf-8?B?QXJvMUJKRnd5Zzc0MXorZ3JLaFEvRkkydGRZWk44Nld5ckNQcGsrQ1VqOStV?=
 =?utf-8?B?NFZmZ1paMmlLU2VBd2xPemQwUTlpUXVaWWNYV1ZtV0RlSVV1Y1M5SXBlbi9t?=
 =?utf-8?B?TURyZUp6bmFiMSszMzJ6OGE0UkhiQUxueldBc0lvY2RkNjB3Z1VoL1lLeVll?=
 =?utf-8?B?TnRFUjdaY2F4cnRWT0hhMmxscjM5RXg0VFhuN2JUQWtjRkkwWmRtV2g0YmRy?=
 =?utf-8?B?cmdmWTYrd3U0RGxmQjZseUdhbHoxT056Rk12aU1JM3JjUFhZTGFyVndCVm54?=
 =?utf-8?B?eDRhQkNCYlhqeHMxQ1BTN00zeGh3Yzg1R3R6ZWIwMkpWRmZjZzZaeUgySXU1?=
 =?utf-8?B?OGRXb0hCRGMxWktVb0RMb2ErVXNEdnlydVJyYkIzVXFXY3JTM0cvMUM4aU9r?=
 =?utf-8?B?eXhzeTlpdkdaTmxXMElOaWw2eCsvQ3hyOXhZNGZ2aEt3N1FJOFRleTl5cDhq?=
 =?utf-8?B?aHBtQkJRejZXK0xnajkyZ2swM3FqN1V3Y3JjRFVTWGNuSk0vbkhwdEpVMysw?=
 =?utf-8?B?OWRpbnFEWk9oczZ1M2hyNTlGWllWcUhwQVY2RTU1WFY1QW1paHZGdGQ1UENu?=
 =?utf-8?B?NWFkODNCWHJlRzdsQ1MrZU9kNSt3L3BuOTZKaThTaEMrUXBlWW42WFIwR3Rk?=
 =?utf-8?B?dm5HaEJHemFpZlY2VVBKRUJIWkl3cE9lUmdZZm1QT1hNM3ZubW9aVFNMVWJ3?=
 =?utf-8?B?UHVvQlRya2RNdjA1TWxHd3c1eE5yNFNWN01RS1dyL2RXRkIvcnlXMGpYZFI2?=
 =?utf-8?B?cjNYbzMzRTFDZEhtUnB0d3NoSDk4OWFQM0NIZG8vaUZSUFNiK1BoVmFWbk0x?=
 =?utf-8?B?Y0g5N1FhN2pIdjZFQ292dExyOGUrYkl6SnJwTGI2RHpTeEJQSE4rR0JIYVlK?=
 =?utf-8?B?S2hJRlpyR0xWbVYrOStIMTRHQ1V5ZmZaUzVZWGRrN2VKSHJYN0lhZEtrb3RP?=
 =?utf-8?B?cTZtTlVtZk5QdjFZS3VuRmR6bzAvcWorcG0wMU8wL2FkTDZ1aFFjdFBOTVF4?=
 =?utf-8?B?bnNsZUs2SW95RXE3VThrQjA0KzRITW1IN3lZOFBNUUxyMm5vM1pzUHBqczhX?=
 =?utf-8?B?UDdhQ1dGRGdkeFQ4SDdia0NxTnNjQVBCb09Cc092N3R6dXB3UTNWZ2FnaEJn?=
 =?utf-8?B?UjNKNk9XdjFLdDBTMGo1S2c3QWN4S2hOUmJMOU5sQ1BhUlRkNlJkeHMzUHFD?=
 =?utf-8?B?ZDJGQ3JQZlZDTk9tUXk2M3dvL1I5YkNNcHJtaEU1aHMwTHpySngvRmFod3Js?=
 =?utf-8?B?aFpqWDJ3WUp4UUNsUUM0T21UMk04SUJiYUFkUkJ0M29uekdWaEwvdElydWRO?=
 =?utf-8?B?Y3pSKy9QS3R0a0tmbWt4RTlpdWFQKyt2Z1ZDdk53Sit3MnFhYUdLc3YyYjl1?=
 =?utf-8?B?WTB2b3pHT0ZnUURHeVZsZGw2UGc5Qi93TXhaNHdpV3MzMUlxSnZiNlNCdFBu?=
 =?utf-8?B?M3F4aGI2SnhmdGNmQ2FzMlBHbG9qWW5RQS8vNU1vVTdCTi9uL2lvQ0tUaENF?=
 =?utf-8?B?dFM1QUsydmN5eVhJTWhtU1VDb0xBS1k2NkZXbUJjUm9rVWxRQzdhUjAxc1o1?=
 =?utf-8?B?d3lUbm9nYzV5MUlORGpjbmdhVENvSnUwOWdpanhHanVGL1Zmd1Z2WjVoNlRL?=
 =?utf-8?B?aFJ1RHlNN1ZnbXdna3JVeHpvVktBVnBkN0RMVzZpL3hsV0dOcFduWnJ3Qldi?=
 =?utf-8?Q?8WRFCcY4gVnof876kz9ywbsw+yhEYWieweXm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXJkc2VnQ3N6azRPS1dkeWdaVlFQUlhlVVFzZmJmVWFPWUhvNGNlTGRDRTY4?=
 =?utf-8?B?WHJJNUJzaDUwa0JuZEl0MEdHdnlLM0xKcmRjOSs1RGhtVEV2RkU3RE9JaUIr?=
 =?utf-8?B?amJCSytBV05zaFNPODhuOW1CblVZRFhZb0l0dDMxYktrTnBURHRCNnZvR3pl?=
 =?utf-8?B?RkdRWFY0ampoWkVMK3hyLy82TDRham5UQ3hYTUx6NFFDTVZsbXZGOFhVSG1X?=
 =?utf-8?B?eXluYUV0akRNdFF3OWxYM05mdVZ1ZVVVQWJmS1NTOWc5TUR2Zk5ZeVNJeThR?=
 =?utf-8?B?cmp1dDZ1dW8xbnJ6MVNDT2grakZvdFA2enNlYkNSL3VSYkpHN21QMHlYamJB?=
 =?utf-8?B?NmZheW5laGtId1ZHcWJrSFQyL2tialMrVGlOWUtoekI3c0k2aEI4eTZWbDJ5?=
 =?utf-8?B?VzFzLzF4dE1NYUM4VFJtT2F3cXZ5K0pRWVh4R1VVaWxsczlrN2N4NGQvZkd2?=
 =?utf-8?B?azBoZ0dIZy8vc0IwbU5XVkhWU0hkelV1UUtZaTBqbjg5em44NjJzY1ZOR09h?=
 =?utf-8?B?VDEwTDhrdGlMb2NQVzVKMDJlWHZWaDZscWdiQ1ZOZDZkemtBWE01c2dRYXhh?=
 =?utf-8?B?R0VoV3VFR05Ycy9qRXNmbWNnZVZ0Mm9VZGwvb0dUbzN5emx5N0U2L3g5ZEJF?=
 =?utf-8?B?RHdRR2JyM3NGVEZDWDZDWGNxdFBpMDBGMnhzNUlNVnVoNlZZU290MVB4TU14?=
 =?utf-8?B?eEFaNGhLMUxDdjdjTHdlMk0zbFJ4cUFyOGZ1bmZlTVdRUGZTTnhIUElaRTl2?=
 =?utf-8?B?Nk1uUFk0NU81d0JDK0o3d1Rjdllzdy82cDU0USs2a1JLYWo3VkZCLzExU1R6?=
 =?utf-8?B?T0xrNC92Q3luTlpJWnYyanQ4eGJyM3NrUnRmZ0ptc0d0bEFiMTRKZGVVN1B2?=
 =?utf-8?B?eEpaZEZHWS80dnUxUkowc1ZXWGpXTFBtdmg3VVNuUmpubUxkVnJwbjQ5dUNI?=
 =?utf-8?B?OXU3cnQ2aDZ5aEpwTitWbWhYdkZybjdyUUVzVUxvUm55MUVheHdPMXltSzdx?=
 =?utf-8?B?R3ZtQ293d1lFWHAzczBVM3BWMDRoNkFCSk13K29IR2pLWWRWZ0IwMlhLMTBI?=
 =?utf-8?B?bEp3Uk01Y3hmaWc0OTlaY0E1b0YvT1g4VFd6cFlJRWNGL3BpOU5TZmhvVk1O?=
 =?utf-8?B?NFlkVTRtUGZvTzJ6OWVIekt0emVnTm1mdXJpYVlKWUtDRzVqQ1ROT0RKSldK?=
 =?utf-8?B?VFY0TXlrSkl5SGUycU1vY29BMG5BUUVHOE1aa3llRlB2c0tGMjNYRzgyR0gw?=
 =?utf-8?B?WDFHREh2dmhLTkpNbU1HcHQ0RGZOdXBUT21Eby8wY0l2cTZCeW1BeGVDQ2tU?=
 =?utf-8?B?YkpqbW5BdlBLMlNnWldnZGtsMjlOalVVbEpGOWptZFY5MlNkVFZBSUxubU16?=
 =?utf-8?B?REZremtYMGIyYThKTXBqRTRvYWEwZ0phakVqN0ltWGtYeW1IbTB6d29MbDlT?=
 =?utf-8?B?ZGszTXMybDl6M1RlaThRVWswWjJTd1JtTjB5NnVIdU41emNOM2dWSmc2eGxK?=
 =?utf-8?B?b25tTTZ5bFMwdWFBa1QxYXpsMGtHeENjVU0vRUZrOTN2WFZMV3JQUVFmbjdX?=
 =?utf-8?B?azg2R2RFbGhVdVZFbGRoQ0dNL3ZxOFg2SFNGMFV4RS9LUFJpSXBaM1pscU9h?=
 =?utf-8?B?RVlWMUFVdVJnZHdHaWpndHZVcHJzdk50VnZMb25Yd01yK1pTcWVhNGo1Y0k0?=
 =?utf-8?B?WGpmaWxGd2xRNkduWm9LSlZ3NDJlS25tUktoQnprSlhpZ0EzZjZHK2FUMXk3?=
 =?utf-8?B?Uk1MUi90MW4wSGRkbXExVm8rcHlrUE9pTmg1dVZXN2ZZeDRuZFdjQkpqRmlh?=
 =?utf-8?B?ZFhoNXVXWWVFSFdzaWFFWkIrZ2Q1dlFJWUlqNUVsY3NxTFhncnNERjBRdzlT?=
 =?utf-8?B?T3lqQ0g4S2g3UVhDVEc5WnFXeUxwVnc3TzFoOWFacjRmTUUrSU95UExTKys3?=
 =?utf-8?B?QlN4ZkNwTm04eFFLSllmRmlkcVVhcmcrL0wyZ2RIVUZkMC9YaUtSZm8wQU40?=
 =?utf-8?B?Q3lwY1RubERpcnJPcy94REJ3Rzc2NTJlYjFqZStxTlluaUtlM3JBWFIrYUNH?=
 =?utf-8?B?ajZjRUcvNks4RUV5YVdUelc1VTdWd1BUelhlRG5seHUzU3BFKzNSenJ5VEZh?=
 =?utf-8?Q?xV6oSGct+8IIXNoxsMYWR5/+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aefed6-e44d-4cfd-4a20-08dd7cf07899
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:10:41.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hzuqaXjQGP9r79HNlMbPCpe0yldYItgPusgTRyilVpRJOhrpDUZGb65X+6WGjhKuDkBmXoKytOeATS3W+S5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

On Tue, Apr 15, 2025 at 09:25:58PM +0000, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD EPYC

This affects Zen-based systems in general, not just the EPYC line.

> SOCs has an Address Mask and a Secondary Address Mask register associated
> with it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS
> granularity during init using these two registers.
> 
> Currently, the module primarily considers only the Address Mask register
> for computing DIMM sizes. The Secondary Address Mask register is only
> considered for odd CS. Additionally, if it has been considered, the
> Address Mask register is ignored altogether for that CS. For
> power-of-two DIMMs, this is not an issue since only the Address Mask
> register is used.
> 
> For non-power-of-two DIMMs, however, the Secondary Address Mask register
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

Checkpatch says this should also have a 'Closes' tag. I never thought
about this before, but it is mentioned in 'Documentation'. 

Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt

> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>

Minor nit: TIP tree handbook say 'Tested-by' goes after your SoB. I
should check my submissions too.

> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Cc: stable@vger.kernel.org
> ```
> Changes in v2:
> 1. Avoid unnecessary variable initialization.
> 2. Modify commit message to accurately reflect the changes.
> 3. Move check for non-zero Address Mask register into the new helper.
> 
> Links:
> v1: https://lore.kernel.org/linux-edac/9a33b6ff-9ce8-4abd-8629-3c9f6a546514@amd.com/T/#mc0b1101055f12ccb06e5a251d16f186597ed4133

Use a 'permalink' rather than this threaded link. Search for
'permalink' on the web page.

Better option is to use this format:
  https://lore.kernel.org/<Message-ID>

As shown in 'Documentation/process/submitting-patches.rst'

Ex:
  https://lore.kernel.org/20250327210718.1640762-1-avadhut.naik@amd.com

Side note: I've been adding 'r/' between lore and Message-ID out of
habit. But it seems that this is no longer needed.

> ---
>  drivers/edac/amd64_edac.c | 57 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 58b1482a0fbb..91d22e63bdb1 100644
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
> @@ -1270,7 +1284,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
>  	int cs_mask_nr = csrow_nr;
> -	u32 addr_mask_orig;
> +	u32 addr_mask = 0, addr_mask_sec = 0;
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
> base-commit: b4d2bada09b17fcd68a0f00811ca7f900ec988e6

This is a tip branch/commit. However, you should use a 'ras' tree branch,
since this patch is totally within EDAC.

Repo:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Branch: edac-for-next

Besides the process notes, the patch looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

