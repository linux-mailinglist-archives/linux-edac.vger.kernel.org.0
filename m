Return-Path: <linux-edac+bounces-5510-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC49C7E456
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 17:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 739AC3414F6
	for <lists+linux-edac@lfdr.de>; Sun, 23 Nov 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDACA2248B9;
	Sun, 23 Nov 2025 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A1SFLKYT"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065084A35;
	Sun, 23 Nov 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916093; cv=fail; b=b30rwMFYTja3gO2syM0+5EA4r714z9LUNX64E983vnrNCjVPuPnShjJaAu/8p/kyUTbMW4WcgPqpOxa4QmLGHguSXr+zyypztoFINNioneGeEz+I2Dex+6u1xgG/2fy7ZcLa1eiQjuq5pUOb9KOs1F5BTSUFLf1KD7sc9VD7RuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916093; c=relaxed/simple;
	bh=10HIUIcOJj1Uah7V5p1VfiPoMHge3hrVeeD33dzdqac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lr/xFyjm4+akE4CN9D3ArBAGHHAoG/bvDDLkmHcaWO4nQEac5Gv8Et5/Qh5/onSu+mwytO9nkLnNO36ysunOqZ6QBKua0e4/0amasikHqilzWnn8jDEUXmSX4wfGmEQ6zoYzvswbrSEB9bZfXWS/fcZwUXBVfwkqeWT3Dk+d9ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A1SFLKYT; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnVlVq7luihqQ6Z7ISYOCUIV4pTwui2Zz4Qbwgs/C66maDGpNT9cGc+RrkTH3kIkLDtyT47TzXwDcYUi831dy4c4PEzqCK/EV+k8VBdhW4nbJE2O60VROBEjrFaKqkR9EU2vgJSYJfGzJnDEFk+uzkRq0k25tlGK0jkB98dNsmN9Hw/ucQ2+VK0t72zyBfqmCsQuML/6isJlts+QppF8KjE1EAHI8ZTeyIKE6n+y3driw17IpqTu4k6e1J5lMwsFW4DJVJuL63j8lC0ITwTz2HitlFNealkIUsQUL/7kXRyxxeFZIY3C6jCIoRAa6OwBiWfXCHK+0DMDfXVI5F5JQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10HIUIcOJj1Uah7V5p1VfiPoMHge3hrVeeD33dzdqac=;
 b=o156Wzw/PAt6Oy07q1hcrxkE+SDKQbFfcybMtrPeL/hQG5dB8gzeRVhw3sdV3ZQMVwM0/Mv2U+JoCCPg9RyMiieKuC6k9oFwrbmC8uQbijWlFCFj/D5N0hdy/Kr/QiOnQKEaNkeq185OCn5FFbztY/dNr9JbidORQirb369+8LURaYnEp0TvP0Zd2c7AS1AnT6urgID87nz3va7OTAH7G7HKly5DakhpV1TV1bZZ/4eKj1KVVuggdRLZhJ61LRXke86B/QhuR7zUg8GJ6P1f3JWenBEumGRjJSjSSstvXoOq1OgQ9f5Y2afF+n3I5+NI3I6opJVP0dWKX+k7N2U1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10HIUIcOJj1Uah7V5p1VfiPoMHge3hrVeeD33dzdqac=;
 b=A1SFLKYTaLfTPDo5dDANvO0nrTtUoxoemqN3TmKD5f0jlBkMu2UDHyf834kn/IB3zNcMCDIEal9Fc9Klqp12gX/ucZ8gf2drng4nLcIFD99PRkSgmxikCLjKCM7GsOeTJuaz00OhlPUxvk7CBzpYkWNoqbmTiVKhBcWzyiVU0qY=
Received: from SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 16:41:26 +0000
Received: from SA3PR12MB7949.namprd12.prod.outlook.com
 ([fe80::8579:ac7f:eaf2:5899]) by SA3PR12MB7949.namprd12.prod.outlook.com
 ([fe80::8579:ac7f:eaf2:5899%6]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 16:41:25 +0000
From: "Vyas, Devang nayanbhai" <Devangnayanbhai.Vyas@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Garidapuri,
 Ramesh" <Ramesh.Garidapuri@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>
Subject: RE: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Thread-Topic: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Thread-Index: AQHcXIVlbAyAMDHD9Uqs3+f0K+8uTLUAY/AAgAASy0A=
Date: Sun, 23 Nov 2025 16:41:25 +0000
Message-ID:
 <SA3PR12MB79493BC93CC40066895300B28AD3A@SA3PR12MB7949.namprd12.prod.outlook.com>
References: <20251123142746.1879744-1-devangnayanbhai.vyas@amd.com>
 <20251123153318.GAaSMpPrSZLkzx8D5c@fat_crate.local>
In-Reply-To: <20251123153318.GAaSMpPrSZLkzx8D5c@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-23T16:40:33.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB7949:EE_|BN7PPF48E601ED5:EE_
x-ms-office365-filtering-correlation-id: 29251139-71d5-4510-c462-08de2aaf24cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?WE4wMENMY3o1RzJ3bTk0c1BONjFlZmtsZTI2eW5qcVVMZ2JEZlhnNThBL3lt?=
 =?utf-8?B?c1Z2aVZLRXJwMEZPbmJ5YkVCQUxBQ3BCMzRXbnhEZHk4UWVFOTdvVmVtUjh3?=
 =?utf-8?B?ZXF0bG9ldzFWK0FhNjNZSThTWmwwMzgvUTlXL1lmTndNUWtydDNPQUIrUWlt?=
 =?utf-8?B?dTMycTJ4bjEyZUtwV2Z2RlZ5WXBTY3RIYW1nNFB2ZVV5a1NZTHFpVnFTNW85?=
 =?utf-8?B?NmM4d0R3ak9KSmk2bzZCSWRXNEZMdmNLU1BoYXVXci9SRVhvTjIzRnpjdDRw?=
 =?utf-8?B?QmxsVm5qdFpyQlAwT2JBazBscFZJcTBTcFVmTTdLREs4V252c3FUQzEyeE5Y?=
 =?utf-8?B?UzNTOGxvZ3QwMjlVTlcyRU9mN2N4eEdNRHByaFk0QTN5NjI2N1FIdVhpdFg0?=
 =?utf-8?B?MXZrTFg0bzhYTldEMUlGbCtaeUFIMkZwdzZVZm5OMVp1K3B6N2d2NmNPWDV3?=
 =?utf-8?B?TnZyV01xdWV5U2JGWWdybEUyL1k5VTlWemFBb1p2cmlWWW1PU0s2TUJzNmEv?=
 =?utf-8?B?TGdaUUJ6MzNEaHNlcFNaNXZOUWtDci9lWGJqaHlMVnI1UWpqQTlEQThqNlJY?=
 =?utf-8?B?bTZvNTBKZ3V3TmdqSkF4T085aFNNK3ZYekwwWUZYV05KOWdGMzNBM29DMi8v?=
 =?utf-8?B?SHFhTmtPcy9CMjNDa3JJZ1V6MEN3eG1GeTVXaFFHN2tYN2w3cjRZZ1Q2bU45?=
 =?utf-8?B?ZTAxRC9oL3F1NVFWMkY0VVZqSDdndit3a1J4Ykw2Zklibjlpc3dJa0hWclpL?=
 =?utf-8?B?ZmpCYXk1TTBha1lQWHhvN2FrN3N2OCt4SzhaSWNjOVFoWUVPa1k2aVJ6a3JS?=
 =?utf-8?B?RnYzU3J5YkFrblo3THdDUUpnOGtXVTVkek1LYUtIRXhJUy9tSDhQcFk1bG1J?=
 =?utf-8?B?Z1ZSM1AzS2NmTGJLalhPeTNpWFZVK0lnWEVBYWxIckNySndMNGhBU2RhY1Ny?=
 =?utf-8?B?YzFKQyt6c1RSZmpwdVFsK0dITk9MS0hTanVJZmUrU054MGlHM1ZjREFUNWRq?=
 =?utf-8?B?T2VmbjJHVkNCbExHaWVEQTBHVkhjR0Y3NVA0TUpxNTQxQ0lEcHE0TDZkWjkv?=
 =?utf-8?B?RkRwTmxJVFhPSjlMNGZsemJQczFBOHpsQ0VRbXFSZXJiVlVYUlUzKzN3aXdB?=
 =?utf-8?B?WVZGQ3d4dTR4YlEzd2hvdEUyTGx2MG1RdjYybnl1a1psckpQWUdTaWFLYWYy?=
 =?utf-8?B?Q3N0RlNsOUpJUmVmZnBjYmFLK0tLVEV6ZHd4U2xmUUFCekhLZ2tYUTl3dEs3?=
 =?utf-8?B?S1ZSQ0dIUnBCTFdyVnRvRUZjZjlwRk5NWHpkeHhzWHpvS1ptL1kxQjZKRndL?=
 =?utf-8?B?UTZDNlRjaWdSd3RZQnV0bUNxekVEelpjbjN3R1RNRUpyK0kwUVEvNUplcmpv?=
 =?utf-8?B?aHhaV1pheEh6dEk4N05DOE90ZGN5dGp4Z3p4WGlXMHkrYjk2dTRUR2o2MGNX?=
 =?utf-8?B?OW9OUjIvNXVScXo4RGVhSUUwNk1xN0NwdG1lcHRvOStDR3hQVlFsQW9DblpS?=
 =?utf-8?B?VlRYUnByMjkzWEhTZVdTV3RUVmI4T2ZmbmVYMkFvOXlMT1hSTytaSk9XTld2?=
 =?utf-8?B?MG8yc2pybW1FYUNrZE9Iei9URkd6MTRueURoT2Y0TDhmWGdsc3RxTm9kSFh5?=
 =?utf-8?B?d2w4UGE1OVNPbzRpcGo4UlJkbGlERTlkaHBXTnM0UForSURkQU9DTjNvOTVk?=
 =?utf-8?B?amorOXc1NEFZRkl5T0E3TWZ6RTR2ekkvNDhVWm5wUlF4YXMzdjBxbmxlakpF?=
 =?utf-8?B?RS9Wa01EdXlNL2prVkQ0YUxlN3dGeEhHL0pxUnVOOGd5RzVUMzZ5MHg1U3dG?=
 =?utf-8?B?UWRlalVCRnNjOWt6WFArR0srMjF0a3dzSGhGUFVHdHJlYzlTTTd4dmFrOENS?=
 =?utf-8?B?ZUw0WnAyT3E3czRaSzlPTkJ6UjFJSlNlcE5DWk9qb2JEYjNOdzQ3emZQWUlM?=
 =?utf-8?B?djZZSzZwTytPeFN6WjB2dkY1NzNVbklsK3Q4MmdCaTVoeUl3MEFzUURieGw1?=
 =?utf-8?B?MjEyNmc0VW1WSzF0WFVNZ3VBdkV1UURUbWQ0a3FneVVQZTYxTEltYlBuL0xN?=
 =?utf-8?Q?5O9IU/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7949.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0RiT1RoajVERmJMaU5iOHBJQk1YWjBtVmxnNmM5MG1GTEc2UktITG85UlRL?=
 =?utf-8?B?aTR5aDNSMkNmbEp3Q2NEL2JpQ0RUdmVVSVlNMndSa1FVWDUzU2xvcFB5RW1C?=
 =?utf-8?B?Q3lUblBmM1FKSmp3NGpWWjdMaC9DQlFPSmFpb00yQUhIUU56VHVTUDFXc05D?=
 =?utf-8?B?SnBKb1NFNUJSVysrR1ZXNitFNFhyVlJ5L2w4VlJVbmxRcXMxeWdadXN0Wlo2?=
 =?utf-8?B?a250anU0SG9SMmdhamFCenB1eE95QzcvbzRqTTZKaUFlM2lzSFQyYndpbTRi?=
 =?utf-8?B?WjF1M0NlbTVJTjJ3YVB3T1dGVW82REFyS1ZFOEU2Q2hmRmk0a1RidGhMQnZK?=
 =?utf-8?B?SjhoLzZ2ekVhVEp3dW1hWHhMMG95c2wwanB3R0tDb3VVTnZDSFd0aitSd05l?=
 =?utf-8?B?bS90MXp6cWhJZi9XbnkxUHh1M1l0Nks4NytzZnc5UUk3NEEyQnRkTW1oRHNE?=
 =?utf-8?B?SVBWM09DNTVaNTRVbU4yVW9PUmQ3L21OSmx6cWhCSzd5MUFTaEo4My8veUJk?=
 =?utf-8?B?TEZjamtrT01McjBhSGRTS2tiU0Rtci8xeGRtVmpWblR3b1NIN29hWFpyTlJn?=
 =?utf-8?B?UWZTb3cyZzBpTHFrbDVaaEE2OEhQaktYVzh4UWwxQnBibEJ4cGFkSmZ6NDY5?=
 =?utf-8?B?c0VOQlA3OGRnd1MwT0MzNnRmaU41ekVFVUZHMHVRRUZGc3czVmcvRDUwenN0?=
 =?utf-8?B?WUsyQlFaUU85ZU90dGJJM3FnZEQ1L0JaOENweGVhRW5nNEFjSmNkTTcxU2Z3?=
 =?utf-8?B?R0kzcEEybno1bjFkcDVraFkxSnA1SFYyc1FUL0xyUlZLRUxjek1lVGdQdXVo?=
 =?utf-8?B?a2Fqd0JVSWkwcnFKY0RBamw4MlVRdEl0Yi9GNEIwMUxIQ2ZEOHRBRm0yQjVH?=
 =?utf-8?B?RHh3SFNOVXZRaHRmTWYzK2ZZVXBpQlRNWkZGcHVBeGU3R1ZmbHlxYXBMTnNa?=
 =?utf-8?B?V3NIaHdCc3pvV0NDT1VUYXhOZmMxdllleDl1VFVRMkhuUlNRM0haTEJkV25T?=
 =?utf-8?B?RTlqWDhDYVkwOWVzT0kvOHFLRVgxVzZ4ZFd3SndkUzBXanFTVXRwOGtlTWRG?=
 =?utf-8?B?U0IxSUFVOVBqWlhOR212dHlVb0JCb2ZOa0FRNzJmM3ppdmFONVZ0eHFPd1pw?=
 =?utf-8?B?MkZEdk1zSG5oV05wRGNOVHZ3ZnlpUVlqczBIcnhMbWRLVXR3WGI1c0x1QjJa?=
 =?utf-8?B?QTd4aGE1QXFLeExPMXVBRG5mdnhEUUh0SGNFS05Jc1RRUFZMY3ovc2k3S3pE?=
 =?utf-8?B?YXlMWVBJWFFEclgvVXQyankvZVZ0Q0FyTEF3N29YODlWWlpRVVhBc2FKeFpn?=
 =?utf-8?B?dndrZlA5bXUvU3AxaUF3UUk4Q1lYVGVWRXR4RFlMeGtuUWwzaHN5WGRhUjNV?=
 =?utf-8?B?NFBmaDlyb0ptZVZnZTl2Yk5vTURXWDc5WnFTOU5LTG9zQ1U5dk50cHZVd2Nn?=
 =?utf-8?B?b2MvalhjUHNRNkZSODRlbjVEeXhEVm1ZOGRmczd2ZkJBVzQza0xKNUVvK3Bw?=
 =?utf-8?B?RmZ6b0RadUZPSzRaeHI4dWRqb3JZb3dhSW0yNFltbU5OT0lnUFg5eERhc1R2?=
 =?utf-8?B?dldvU1RpQ0c0dnV4dnRFaStNSmI5dXh6ektNT1Fic3F6R20xMFc0VUI4b1Jl?=
 =?utf-8?B?V05YNUVQeXhzOURhdzYrQnpWbFdxYWVRMHh1ZE5BZkNqS251d0diL09jdGpz?=
 =?utf-8?B?R3R3MmFZZVlwOUt1S25LNjQrNUdoZUN2UTNmMjVrQ01RZUdYSkhLdVg4SUpH?=
 =?utf-8?B?TVV1cml2Q3RGZStvakYyWW9SMGdnSFpiWmFsRTRwMjFnQloybHQ4OUxlVzVa?=
 =?utf-8?B?ektGUFJGQ0hzeUxoMGd5c2ZtQVI2OThuNmRlS1hlL0pyckxOU1JOV1N3dmV5?=
 =?utf-8?B?QWdEK0NjVHQ0RWoydUlucEJ3eHdENWtTYWlaRWFPbWVHcFFBZ2pEZ0hNdUNz?=
 =?utf-8?B?bDV2VWxJUW9veHMvQ2lpbC9maysxcjM4cWErSzlMR1RaREZIQWdpbmdLRGhq?=
 =?utf-8?B?b0hVMzRBRm8xOFFUNDFDZkovdlNGUThzQU9OKzZUcjJDTXFFaDBTdHFDM2sv?=
 =?utf-8?B?TUxsV0JsRWtpZjRUY1U4MnovcGlJanI1clA2WGo0ZUUxUGo1RllZUS9aSitC?=
 =?utf-8?Q?15qs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7949.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29251139-71d5-4510-c462-08de2aaf24cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2025 16:41:25.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgoDVIc4DixGWpBvAcDLGR5DLH8G0k8eNP1JVtuWyvOMK5J1z1N/Z619fmm6Zwn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGVsbG8sDQoNCkRvIEkgbmVlZCB0byByYWlzZSB0aGUgcGF0Y2ggYXQgYmVsb3c/DQoNCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jhcy9yYXMuZ2l0
DQoNCmVkYWMtZm9yLW5leHQgYnJhbmNoDQoNClBsZWFzZSBjb25maXJtPw0KDQpUaGFua3MgJiBS
ZWdhcmRzLA0KRGV2YW5nIFZ5YXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KU2VudDogU3VuZGF5LCBOb3ZlbWJlciAy
MywgMjAyNSA5OjAzIFBNDQpUbzogVnlhcywgRGV2YW5nIG5heWFuYmhhaSA8RGV2YW5nbmF5YW5i
aGFpLlZ5YXNAYW1kLmNvbT4NCkNjOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQu
Y29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsgbWNoZWhhYkBr
ZXJuZWwub3JnOyBycmljQGtlcm5lbC5vcmc7IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHYXJpZGFwdXJpLCBSYW1lc2ggPFJhbWVzaC5H
YXJpZGFwdXJpQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBFREFDL2FtZDY0OiBBZGQgc3VwcG9ydCBm
b3IgZmFtaWx5IDE5aCwgbW9kZWxzIDQwaC00ZmgNCg0KT24gU3VuLCBOb3YgMjMsIDIwMjUgYXQg
MDc6NTc6NDVQTSArMDUzMCwgRGV2YW5nIFZ5YXMgd3JvdGU6DQoNCi1FTk9DT01NSVRNRVNTQUdF
DQoNClVzZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZXhwbGFpbiB3aHkgdGhvc2UgbmVlZCB0byBs
b2FkIHRoZSBFREFDIGRyaXZlciBhdCBhbGwuDQoNCj4gQ28tZGV2ZWxvcGVkLWJ5OiBSYW1lc2gg
R2FyaWRhcHVyaSA8cmFtZXNoLmdhcmlkYXB1cmlAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UmFtZXNoIEdhcmlkYXB1cmkgPHJhbWVzaC5nYXJpZGFwdXJpQGFtZC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IERldmFuZyBWeWFzIDxkZXZhbmduYXlhbmJoYWkudnlhc0BhbWQuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9hbWQ2NF9l
ZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+IGluZGV4IGExN2YzYzBjZGZhNi4u
MmY2YzNjNGVkNTU3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+
ICsrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gQEAgLTM4NzgsNiArMzg3OCwxMCBA
QCBzdGF0aWMgaW50IHBlcl9mYW1pbHlfaW5pdChzdHJ1Y3QgYW1kNjRfcHZ0ICpwdnQpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB2dC0+bWF4X21jcyAgICAgICAgICAgID0gODsN
Cj4gICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiArICAgICAgICAgICAgIGNhc2UgMHg0MCAuLi4gMHg0ZjoNCj4gKyAgICAgICAgICAgICAg
ICAgICAgIHB2dC0+Y3RsX25hbWUgICAgICAgICAgICAgICAgICAgPSAiRjE5aF9NNDBoIjsNCj4g
KyAgICAgICAgICAgICAgICAgICAgIHB2dC0+bWF4X21jcyAgICAgICAgICAgICAgICAgICAgPSA0
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgY2FzZSAw
eDUwIC4uLiAweDVmOg0KPiAgICAgICAgICAgICAgICAgICAgICAgcHZ0LT5jdGxfbmFtZSAgICAg
ICAgICAgICAgICAgICA9ICJGMTloX001MGgiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+IC0tDQoNCkVEQUMgcGF0Y2hlcyBuZWVkIHRvIGJlIGRvbmUgYWdhaW5zdDoNCg0KaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmFzL3Jhcy5naXQN
Cg0KdGhlIGVkYWMtZm9yLW5leHQgYnJhbmNoLg0KDQpUaHguDQoNCi0tDQpSZWdhcmRzL0dydXNz
LA0KICAgIEJvcmlzLg0KDQpodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJv
dXQtbmV0aXF1ZXR0ZQ0K

