Return-Path: <linux-edac+bounces-1720-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8495A4EE
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177A11F23996
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B21B3B14;
	Wed, 21 Aug 2024 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfNQAskB"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A016DC15;
	Wed, 21 Aug 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266509; cv=fail; b=AtXzP/7EaIx53qyrM9vgBdte6WYtwLc2f5S83umO0956qKlDgme2iwUw7UkJ9JdiSDxYimVoFvUAYznEhLG9TTsERX7C2ct6exJjh6azPfDAcQPoXOcrUplajPZ7eOh3ulv0xyBqcNhrsJMkPGc5qAYldydyCzaqojJ5/LiVgkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266509; c=relaxed/simple;
	bh=hjqlzhCTQi8tjt57YbtZnsC0MiRKioKs62mQYKwAESU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXbkEHAJWyL9HUCElfR1iUKBxb9F3Kg87ESAaOAF369cy+AK88Ee3fJstRvoZMRhWThHQI2YCIb5bR65GJLkIs+OTUU6u+c/kgK4Fjs6rLhljycNT/oOPXm5SNSN3jHfrbcDUhG9RizVT3GJjccMy2mgdPjDfxHGuaQy1gChw7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfNQAskB; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1oub5aEtSa2PUYXuWwlu96L7fiYN1FUcYthFx0mODcufanZ0LZ6G7X/26YZyu3O70DtjT52egfEjfhEDAj068dVDCPjmXe1IVjk58rJFL9KgqbLQgzl9eZKdLcTqx9Zt2uWiK44u1FvWp2jQHCN3hmR0M4bS5tBN9HqimIKrRxcEzwDZ62cSPI2GDE+UOdsBE7wlJoa3f/PjoDMohPhXmveSmHiT4nrRRD4Yf6Q36hcpyb4f9VT9fHW9/X4xoqt00IMVlnW7hV0tCexPff9xf8DOsUXzXARTkQMHyrTzNITwZ7FDEfxm/k7k8sYsg6/PkDzkUb4Bkd83ZKu0DKUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDI8Np5dGX9d3rD4N+CVcI5wqckmUcBngFPeRiTvE3A=;
 b=UoFfSFy3sU6KhCqbjXkfk1+wbHySqtM5hk0mbAksQAEqJLAzHuvidalrYsYrmznYnwvfndhuMiOdX58NzMXFvkLEj5V0PQVXz555RX5v30iX4PUtgilVKoE5dvJz/JlJT/2jtWBJIWc79JMGLEpLaQSqkvKAOEzsj/BnA58Xn2+hISVq+Qbzy4R2IVgBOfuXbXZIjBtWMVe+7p572rf319CjOEE+ssCGWr+pp5pOT7DN1IKcacn/TjofSIOWDjB6nUCDYg076FtHOrgzjLMIpH6O2jz0Uo3+y4GgULCp08rDqi7zBMrxLoQM5pw2VU1JKY0fz9UeJunoFZ+roZHrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDI8Np5dGX9d3rD4N+CVcI5wqckmUcBngFPeRiTvE3A=;
 b=yfNQAskB/A0rMoeamT7GY1EDGeTsqdAkGNq0g+Gjppgx+ZAe4i3dmh4yJruXNWLrgJwywUZzbL4RzzBFlUy3ueyGJE7ibjBUNqM0ByU9IaEv8XxwmE6SuuIRPNb9XfoFeyTZXmrOgnhHLIyp/ROkNqtWobfOrWxOXqtoh5xnLi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 18:55:03 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:55:03 +0000
Message-ID: <9189a857-8c7b-42ac-958b-89a3d6a7ded5@amd.com>
Date: Wed, 21 Aug 2024 13:55:00 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
 rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240815211635.1336721-1-avadhut.naik@amd.com>
 <20240815211635.1336721-3-avadhut.naik@amd.com>
 <20240821134057.6fc50940@gandalf.local.home>
Content-Language: en-US
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20240821134057.6fc50940@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3cf2b7-acc7-4ccf-4c12-08dcc212c39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkk0bkhnbk14cWFiY3NFR2JBYXpIWFRMN2loOXRHVHhtTmE0M1FtUzlIVEZl?=
 =?utf-8?B?RnVxMFZYcVRMRDVBdGF6TDRlUmdGOGpNREx2dWVhejNCcTh4U2t1bWlReVg5?=
 =?utf-8?B?aldjZ0M5T1RDVnFqRFQvb09QQUdHRUxYWGtzVXowdGlUWU9xblBJQlo4RzNK?=
 =?utf-8?B?QmxzM2ppUzhhUjlFbFdSS05sdWJhZGYxWWYrRFcyTWpjbGNadHFRR2dvUkpq?=
 =?utf-8?B?amZ2b0cwYmdibTh3OFg3T3VXY2t0QWxGdlBsZndtaGkxQ2NuZnVWYUlwMTBG?=
 =?utf-8?B?eUJHN2g1SUFYem5rSE5ubHpoS1VmRENIRmNHNmVEQ1kyTDlkZHgrL1hLWHNo?=
 =?utf-8?B?SzhkbE1vd2xQcFp5WENpZ2NTd2k5RFZHSHdxOWF0Qmt6RGV2QVpheEtXSTY0?=
 =?utf-8?B?dmJ0d2dFdHc2ekFjdTdEajNmQ2lJMkRZWVFYS0Iwek9NYUJKdWdCWjBEdDVs?=
 =?utf-8?B?cTYyUmhOb3VKRVpyWkg3Y25rUGlXWURaV2tzOVBEa1UySUVTTlFzbWw3cDht?=
 =?utf-8?B?YmF4TFp4djJ5Tk1sditxNFNrN1BtSXd5eVBiaitrcEJYMWl0RW44b3RhNnFo?=
 =?utf-8?B?VmpDMDFMb3hyU3hhTHNZeDJpWXBtMlhyZithdVdSTXZERXdUT1NabjVLWVV6?=
 =?utf-8?B?ZmNaY0RwMFZIQWQ5OXhobXZRRUN6TzRlZkFUUjJBM2ZTZlRBelpxbHMrdnBx?=
 =?utf-8?B?enlFcFdySVNhUm03ZFZ0RnRjaUJxdzlRWStSb1ZtYXMyZEFmQWllNVZ2WnJs?=
 =?utf-8?B?MlNOZmZYc010NXR3Z3lJSDNEZ2hDTVlnNDBuZU1DRW1XVUxESnVXRENYcWZh?=
 =?utf-8?B?bmZDeUE3bDYrM2I4cklWQXNLZGVKUGRwNURVL0pWTWV4NklENk5yNjZ5b2Mx?=
 =?utf-8?B?MHUrWVhUalJkN25laGxkTElpc2V2MzNYMGNuWkdnYksySm5JOS9VcXh6RmU0?=
 =?utf-8?B?QS9YclVlSUxUSzNPdFRXMGY1T3BtcDdqOHJnclhVVkpsYmNyZDZkTkhTNGdC?=
 =?utf-8?B?ZFAyUCtiZUpQaEs2Wnlhb0NuR2tvNXhjRmRZUDhieHJQU1djR1B0WVI1d21z?=
 =?utf-8?B?TzZzc0dtc2s1T1liYWFmUVdEZGVoUWdlc09UQW04N292YVZ0Wk9sMllOQkZX?=
 =?utf-8?B?YVBkQmhQYWNDMFFrVHFFSkQ0Qm9yRk1hN0R4ODh5YUhUdjFJRVBtT3luSHFL?=
 =?utf-8?B?ZXpFdlYrdHpqclZFN0szcnMxZElKK2dHcE03YTBpeGtpdDlBVjhLMWtlMWNU?=
 =?utf-8?B?SUxrai9PNzhhaU00Z1JsQmdFbDBtVnJIMVljTjlGaitxRmM0ZjJhYnFZTnJz?=
 =?utf-8?B?MWxOVC80WHZZYjlMekNlTldaT25FVWhoWkFEWVE5WkVBMVJMcEszMGduSTVs?=
 =?utf-8?B?ZE9SSlFPOURvZ1NoL0p3OUdWcms0UkZrV1VLVWFWWjlBeW5GaW9mcyt6TWQ2?=
 =?utf-8?B?QWtSS09qR09mSXAydnRxeEN5Ynl4VFZ4bmhFQlBlWUlRcEpHditQZmh0UDZ5?=
 =?utf-8?B?bC9VVGJSb3l4VUZvQUFIN0tpQUZENS9sb2hYU0RIbER2M3RaYXhlNFQ3Vkc2?=
 =?utf-8?B?N3NOc1hLNi90dmlQd2ZkVWNYS1piS3B1NVJEdVdOa3BaQ2QzSGRvL0RKUUVv?=
 =?utf-8?B?ZzZvdnhmNzBwYkZkM1dYTGVpMUpQR0VVZ0xMcmNhTzVNODdVdVlGNGhVcUpY?=
 =?utf-8?B?dEhUbDRNaGNISnBEUCtVdzRnUDFtQzNNcUFFNERLMXdxb0VtcW5USk5ZSE9R?=
 =?utf-8?B?dWNxb3A0TDJ3bllzQ0VFcFI3MVQ1RlNRZE5UWG9CU25EQ29hV3JZalE5L3Qz?=
 =?utf-8?B?d28yU2w5WlZSTW9GRnRpdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdTM2lBV3VIMDJYMzNxRGZqSVBSbGtDYVgxKzdoSU1nbW96bzV3eEpycDY3?=
 =?utf-8?B?OG81eExFbFhNQW10dFJBZStOblFaWllpVjJXcUlkL2RBOXQ1SVJsZW1pYmVS?=
 =?utf-8?B?T2JwQVV4QXJWejNESm95NzNLempTejVPR3Jzb2JmNDdSNjI5bGpodWUxS20x?=
 =?utf-8?B?Ly9rN3hHdzdnbFM2ODlCKytjcXB2eHBSeGZGb3R0VWVscWtpQVMxSFdkUUlI?=
 =?utf-8?B?cDZEQnBDdkoySTlQTkRHa2d5RTRnQjFQRWI2blE5bTUzV0h0ZzhhNkdvQjAx?=
 =?utf-8?B?YWRUdnc0WTBZcTJ5SlJQQ01VK2ZEQm4yVDYvSEtiN3VJRGI4WXdycFI4OXZz?=
 =?utf-8?B?NzV3NEpFeWxYMUVLS3NpNTJCdEJtVVk1UTRxUi9wZ1owZ1MyRHJtRkdUUGVW?=
 =?utf-8?B?SmZzUi9obmswYXlta01Meit6VEEycGNvZTdRdE1XV21VaGh1QWNEZFZiZk13?=
 =?utf-8?B?VHlwWTllMlJDV0FBcHA5cmxzdnQrWm8xQjNVS203QUxDajAvSkVzb0dLRERY?=
 =?utf-8?B?V1lqa2NRb1E3MjlmWUV4cGVYY1JxMEFXNnc4SHZ3Tld6ZFdnZjErUHd6RHdO?=
 =?utf-8?B?WUFNMi91SE1jSzQ4SmxZVzRpL2RJTHFJbHdWQUFGVWsvamhUWXRoemN1cGRT?=
 =?utf-8?B?Vm5VVXZYK0dQUFdKWFVjR1VSQUpZNXVjajNhY2M2OFVZak9CYW9YQ281cnY0?=
 =?utf-8?B?bEt6M0hwYTRZZzJxb2JtN09FWllFeEtQSTEvU2Z2cEc0MGQwY2ZEY3hoaWhW?=
 =?utf-8?B?cGk1eHd6ck9rNU5ram1CV01vNFAyc1VVV3liTTFocHRjUUgrQ0FIRWd0UXlo?=
 =?utf-8?B?Q0RoMHg1R0k5UWVLd2dzQnZzZW1WemZNQTNSQVppOUFHUmtua3BNSG1uWmdS?=
 =?utf-8?B?ZEp1WUFjOGNBRTV0MS94V1BZbWdNK2Zub3hoVDZVZ1gxMnNER3pWUWpqbmJx?=
 =?utf-8?B?eEJ3a0xQcHlseXd0TGlWd1BRZkhyYldyREVMdlV4YkJFamhaM0lkZTVuK000?=
 =?utf-8?B?L0RWTzQwQWJ5VnQvOGlzS2FWbnFRUS9KcHJQNU9qOC9NZk5kaThLaHE5QmtQ?=
 =?utf-8?B?bG1LTXRMTDBydkdLSFo1cnpKMXhYZE1kSjBjcjZOVW9UTVVBQTZLL0IzSEl1?=
 =?utf-8?B?QjVnNFN4TzRoNWFCT1ZwSkR4V0VoTE1aN05VdW9KSHh0N1M1VjVGM2R3TDcz?=
 =?utf-8?B?RitzYTRtVnNzem5GQmowNStqR3AzaDVBTklmV3Nxd2NyUGJvOWwxMkh3djdh?=
 =?utf-8?B?bkZ0VG9vRXh1MFYyelp1ZjFiSTRsRzFMMkdOc1FOaHNVRy9YTndNMmd1RXFN?=
 =?utf-8?B?NGFMQzFFNE90c0dRNWZsM0FHelNCSGdzd1RUVkJUTXB4bWpMZS9NNHloTVZl?=
 =?utf-8?B?dkF6SVRobUZpWnBSYWMwbjVBckMycXFnUnBWdk9iWmZOdkFRSVhxN2c4b3l4?=
 =?utf-8?B?WVFnWWtURjROK3R1enBTb0RwbU03SHJHUU5IOEpGZENSVnBudmFiR0JvOGR5?=
 =?utf-8?B?TDc5MDBGVUVlYVRBSkhOOTkxam5yejBQR1ZBWW9lNmVDdnY1dWRJRytZMHZV?=
 =?utf-8?B?RzRBcHIxN2xycGY2T1VBWEVHTkJBWGhKWlZ6RW9NL20rdlNMVlVRK2JBVFlO?=
 =?utf-8?B?WW1INkN0VlpXMEJpb1hPY21RQWp1WmNWWllXQkFFSEJ4UWdOa29yVkFPT3Jh?=
 =?utf-8?B?N015TkRlQVRQRHNZN0g1d2NkbFl4QjgxMDEwWG1ZR2NMWmRZRVRFQmhKTlN0?=
 =?utf-8?B?dUxBZVMwbWdNT1RnV216UURmbVdqTUlZOXdHUWF5eENuL3R0anJKUHdzZmx0?=
 =?utf-8?B?K0dWV1BPNHY3d1dJbkhUeGJGdjBwbFprSTJ0TEtiWXlnRFpzTzdsMDlWdlNk?=
 =?utf-8?B?dW1aQkhtVUpxT09kUklwT0d4bVA3OGwzUEl3RGd1QXhSRlRWNUxZVmZJcDZC?=
 =?utf-8?B?QlF3MXdESFpDaUNjZTk5bkQySldHWTlWc3lIbGt2dG05VmdPOEMvL014WUN1?=
 =?utf-8?B?QTdETUdDSWZMUi9TbFpJd3VvV0QrSUUzQ1VsemIzaDFjZTl6Ym0vKzRoQVFB?=
 =?utf-8?B?SnFxUDlPM2RtLzZ1RklvMGtzU2hpeGJRa3BSSnpxSm0zRlJVQTdKdFYvdGov?=
 =?utf-8?Q?R23hkJnddhfLrmw43AsK0Z/tc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3cf2b7-acc7-4ccf-4c12-08dcc212c39f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:55:03.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA2/4XvaDsGUWfpUSGw3dd7/mjSaCq+wlIWgQ7tRq0eeB3FN+JGnmOjBh3hiyHakUlmVGMbVZQ3Kc9ed5PNutg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611



On 8/21/24 12:40, Steven Rostedt wrote:
> On Thu, 15 Aug 2024 16:16:33 -0500
> Avadhut Naik <avadhut.naik@amd.com> wrote:
> 
>> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
>> index 65aba1afcd07..1e7d5696b3ba 100644
>> --- a/include/trace/events/mce.h
>> +++ b/include/trace/events/mce.h
>> @@ -43,6 +43,8 @@ TRACE_EVENT(mce_record,
>>  		__field(	u8,		bank		)
>>  		__field(	u8,		cpuvendor	)
>>  		__field(	u32,		microcode	)
>> +		__field(	u8,		len	)
> 
> You don't need to save the length. It's already saved in the
> __dynamic_array meta data.
> 
That helps! Will remove the len field.

>> +		__dynamic_array(u8, v_data, sizeof(err->vendor))
>>  	),
>>  
>>  	TP_fast_assign(
>> @@ -65,9 +67,11 @@ TRACE_EVENT(mce_record,
>>  		__entry->bank		= err->m.bank;
>>  		__entry->cpuvendor	= err->m.cpuvendor;
>>  		__entry->microcode	= err->m.microcode;
>> +		__entry->len		= sizeof(err->vendor);
>> +		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
>>  	),
>>  
>> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
>> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
>>  		__entry->cpu,
>>  		__entry->mcgcap, __entry->mcgstatus,
>>  		__entry->bank, __entry->status,
>> @@ -83,7 +87,8 @@ TRACE_EVENT(mce_record,
>>  		__entry->walltime,
>>  		__entry->socketid,
>>  		__entry->apicid,
>> -		__entry->microcode)
>> +		__entry->microcode,
>> +		__print_array(__get_dynamic_array(v_data), __entry->len / 8, 8))
> 
> You can replace the __entry->len with:
> 
> 		__print_array(__get_dynamic_array(v_data), __get_dynamic_array_len(v_data) / 8, 8))
> 
> Hmm, I should add a helper function that would do the same with just:
> 
> 		__print_dynamic_array(vdata, 8);
> 
> Where it will have __print_dynamic_array(array-name, el-size)
> 
> -- Steve
> 
Thanks for the patch! Will incorporate it this set.

I did, however, have another question. This was actually raised in an earlier
version of this set by Boris and Tony. Not very sure about the answer though.

Is there a way through which we can make the tracepoints smarter i.e. have
conditional checks in them?

To provide some more context, as of now, the v_data dynamic array above will
contain vendor-specific data only on AMD systems. On Intel systems, IIUC,
its contents will be 0x0.

Consequently, the tracepoint output on Intel systems will have some thing like
"0x0,0x0,0x0" at the end.

Is there some way through which we can work around this? Can we perform a
vendor check inside the tracepoint so that the above dynamic array is logged
only on AMD systems and not on Intel systems?

-- 
Thanks,
Avadhut Naik


