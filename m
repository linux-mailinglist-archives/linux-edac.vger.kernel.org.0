Return-Path: <linux-edac+bounces-5150-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8970DBFA2B8
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 08:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC9734E3CDE
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D432ECD2E;
	Wed, 22 Oct 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dCkM7kBC"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1D2E8DE8;
	Wed, 22 Oct 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113247; cv=fail; b=l/eDnYlSKcP6Z4VOOfQC5rr/i1ICy6El2Zqw6X6YOPvv4id/2/d1OnxB6tJzgTT77g9NxpuBNE7C5eiGGZp+a8iXbV9WCRI268ZPeKeIzmyg74Xl+/GPsa8L2UNSvNU37iRUI6oQVe3eQIplq/DOc6+TQpC77ZooIE2WLtZN2ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113247; c=relaxed/simple;
	bh=jWqWnYXtxsIB62pATEfSPMc5bbwao90MnxhmWp/13q8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juadlc6r1KuY2Q04WKQR8Ygx1kVfMVI3vyNCYjOROj+fAeIEwlGMRErbAvazDjlhuCe3tZj0qLOCn4zsRh9djY/voOHdPUjcNikDvCbSdjb9WCRh4/65mkMLkI75SalHoy4Y0vkC4zx7nQut6KyLBUlpnThanj31DXnKaFjTuNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dCkM7kBC; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMLMq+xERYrRq/nlRwAQpHqezrdbXEeumY0JbAU8TaCFIIjvMQcVhX9oWwAx9dlxWEeu8KViLHB4yXfVIwrS5fB6SUXw6myRQVx/dSl77R9cRaWAbI7oMKm0eLbS3+tR5x5U4oyJLuxZaIiOUaVVLClgnltmu9awk69xeaCGllBVlxlKpvkWlahA+ZWaIwqCoClpquBX5HzFFbcWMpLvt9yxG3oX1+USZRZ2/OAAI7JFx2D4jpUj4IBvwLiIS0+6q29Lpa3dLzma8rAFe5p0ksbUZu/cno4KxtXS65573N4j566O7bOotLmoRD7k2VWMcyQdekoCvTQPN7A0YdSaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG03P34CQoIeTkHD34qugL8brLJuESH+Fj1s3zw4mnA=;
 b=negsqWJ7WSm6uAw1w/onbTcvYokv+T8HxaBzOOwrdtCWW15i6UOzkIkr47pxLjEI0Ljs4cNbaxUoreAPh3QzgRKEkFWR114+J8FC/hd4MTZzijxQQ9vMeQG0FA5MbCIrOIsAYfEtykhvDYAcvEaBcup1BrA0PYOT90zw6nASnjBKMD2lmAz7Nr+bWSsc3EpY/aDg8WWql9pJKw6w0Bh0Qm2szR61v6mOuFhCwRMsGmEDYKWsJ4YcAm+4qpb/oPBsJxxgF9zGTZ4+NGmUXAQLf5WWsjrbb1d2kHhagD4JAVk0i0f9xBBWzDkPSqflogwB0GMqUtLMNCF81vKyT8wYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG03P34CQoIeTkHD34qugL8brLJuESH+Fj1s3zw4mnA=;
 b=dCkM7kBCVuhr4xhlD1J4uNdUfytkwlcxiDxPflIvKWEL+O5nrxJBvvMU6EQBDHb6b1o4b11+VjqFWqN0pN78v3/IPenI9DVR+E/wlv2UPR8JjH0nil+pMtWeYsYvORbUPJd0UU0ULO0fU27rk6ddHgfi4s4B1eMIf8c2+UD9qWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Wed, 22 Oct
 2025 06:07:23 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:07:22 +0000
Message-ID: <5b4c5e2d-75c3-4236-81ad-ddc94945a54b@amd.com>
Date: Wed, 22 Oct 2025 01:07:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] EDAC/amd64: Remove NUM_CONTROLLERS macro
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-3-avadhut.naik@amd.com>
 <20251021104426.GJaPdkCgb5JjXqvSZz@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251021104426.GJaPdkCgb5JjXqvSZz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0153.namprd02.prod.outlook.com
 (2603:10b6:5:332::20) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9bbcb4-e3ee-4d67-bab4-08de1131441e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1VBM09xa3Y2YnBiWEVyZ04vY2RPRTVxVVFRc0tlWllHNE1jelpXbktnR29D?=
 =?utf-8?B?cmNpeUhrdEdGdGJxVERSZytXcjdQNmR0UGtUMUZyMHAvTkhtYlB1SVRiK2Js?=
 =?utf-8?B?MWxkZHZvc0I1aWwvQkhJa1FSdmVrUCtnTnh0QU1MRjBqUVZuKzQyYlJRRVdL?=
 =?utf-8?B?WnZ4dUwzS3NaQWZpRDhsSW1UQmJHWXBjL2JheG9nWWtWdFYwRElDMnlZdi9x?=
 =?utf-8?B?c2gxU3B1TFIwQlg1UTIzTWFwclpxdldrbjUreCtVbDJXcm5BQjJ2cTRXcStH?=
 =?utf-8?B?dm14T3lqWTFJcW1RSldCcGZBb0NIRVRWUjh5ZmlrMitDakEwRzU2NjJUMGs5?=
 =?utf-8?B?Tkp5ZTlDOGpFd2JXbnA2ZVJjSXNaNG40RnlmSlFZNCt0bmhBdnp1QUtxd3Rq?=
 =?utf-8?B?K1NhMVBsR2ZOQ1RGYXMzcG54VWV3ajVraGdFN3lTYWI0S2phM3M0N0xqS1Ur?=
 =?utf-8?B?Z3Q2V05sZHAvcFR0ZlB3T0s3MlJaS2hiNEJPazZITFkwM2xVUklKL0tJSTJr?=
 =?utf-8?B?UHV3V05Vb0pSY0xoc0Fua2pWZGR1Skx6b0VLM1prYnFqcTFvc0JHdWNkMnFk?=
 =?utf-8?B?U2NYcE5hTFJZM01mV2hOSGhPZDBqZEs4amRiMGhVbXVlSld0Wmx1c0hkTnQr?=
 =?utf-8?B?aW1UYXFmVXl3RXpnM1lETW8rQ1Z2S250Rmpzb3ZHQytWUXFmaWxRK2Z1T3gz?=
 =?utf-8?B?REtsUnhibDZINnhSTVQ5VFVYRFhNWGFiQ0Uyb1F2Q0IvdkNZSXdDYUh1Y2hM?=
 =?utf-8?B?Zm5UNXhJVW1WSVVLaHJzZnpVYlYyVjlRM2lWMjQwdWVnd0ozdjM3SmVwZWlB?=
 =?utf-8?B?NjlZZzRPVFlXMHBoZEtuT3NldHNmYUplRjlOalJwMkZGWlF2R0tlUCtkb0x0?=
 =?utf-8?B?bVlQekhMR0NvaEErTU92RWdWeFE0dnpzTEdnT0doTHZPR3VrSnI5d2x5ZkxO?=
 =?utf-8?B?UkZrVzlFZVcrVXlteUJHR2RsWU4wN3FXWWZXZUtud2MrSkJSd0N1bktLK0NP?=
 =?utf-8?B?TzJ1d3JmU1pJKzBOckhndjZ1dW1Ud2l1b1VJQm5xd3dXSnJHeW5mYm83Znk4?=
 =?utf-8?B?cERsMzh0RDNwdHI0UWUzUlBENEs0R1VUZzdlMGlaYXpENGp0dDZkcGpBVnlG?=
 =?utf-8?B?SkdScUYvSGc3WGVlMnc3dEd6dndFQWU1K2xZR1NNUUZxWi91R1M3aXZBdGEr?=
 =?utf-8?B?YmVOREkwLzJNY1k3dWVCeXFyTDNHUFpBUkxoV1Q3SWtUc2l2OE0vQk9TdVpW?=
 =?utf-8?B?c1h4b3J5aVdnM1V0R3NrMXBObENMM3hRb1kvbkc3MDIzV3BlU0EzOU94UFM0?=
 =?utf-8?B?RjVXNHRuMEdmZjFLV3owZHFPVlFuZUhrU3R0bHRHVm1CaUl0TmEwVVNuRG05?=
 =?utf-8?B?SFZUZW81OGtsVzJHOG8xbllaS2ttY1lFUFN0UXB3Zy96V1V1YU42VGlSSkxU?=
 =?utf-8?B?SWx0ZkRPblAyWUJ4WnhNSS84NHpYSFYxTWVMVVVrRk0vK1ExdVZoSUozSEJ4?=
 =?utf-8?B?SHdwRkw5SHM1WkFhU1k3UnA3MWVHbHZhSDI5SDhKUmlZbVJHL0F3OU83cWxU?=
 =?utf-8?B?bTE5MHZIcFJVY2hQTDkvaFdUNG01QlZHZHpIQzc4dXZHU3hNQlFvVlAzOW9Y?=
 =?utf-8?B?TUU0NUZEd2NDdWZkNXdaMUZIOVphOTZ4cEo4NGI2SEZ3TUFPZ0pOK1MveXBr?=
 =?utf-8?B?a0s4bThpaVExcmJ6SXJ2emp1Y0UranBLS2FRUmNYcmo3YkwrNVQwSHhSN1o4?=
 =?utf-8?B?Zyt2L0daYUV2Z1hGYk5xdjRNQXMxckFWK1c4cDFrRlJpekRkVForUEJUeE9Y?=
 =?utf-8?B?dFZjN0tQdmhxZmxtcHZ5ZVQ1bUpSeVZPakRzZ1FBOWNGblRoU0ZNeVYxd0sv?=
 =?utf-8?B?RTZkc1p4cmhvK21vOWcvdGQwZUM1MHJoRWQzZ2V0WUFkOFZMQkF1TzBNQkdS?=
 =?utf-8?Q?JbnZyk2rXHr5Wxg1rLu3saPhtZU0KTZF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9EZ0dpRTM4ZFN5b1dYWXVrRjZIN1VhV1Q1V3d5R2ZZaExZV3hGa1pJUGNV?=
 =?utf-8?B?bjVZNXB4c3hkWU5idHRUallCdXg4ZFRTUDM5dk5wbnlJZ3N6MTNaeHVib25r?=
 =?utf-8?B?b2diSnlFcUpMQS82dThJOENIQi93dFhQdjYzL24xQ2libVpqb3U2L3dsbjkz?=
 =?utf-8?B?am9Ybkw3UG1NSEF4TjlsKzhyd3dqczRGQndkaVJGZXhGU25UMWY0REF4dWQr?=
 =?utf-8?B?UkJFTVhGTU84eFo4ZERER2l4RUlMRnZJWmNscmFPNnpsYVJLc1NnLzVxcUhz?=
 =?utf-8?B?dGdZWnh3cUJIalBhUS94MGtoWlYvWkRRVDZtckRhZmZ5Q2dJVXZ0SVBpK3Vo?=
 =?utf-8?B?MENseVAyWDFuQ0dDTm9NVHVHTWpmWGRHaUt6cXdLbEJUdVhhLytwOFdnNGhE?=
 =?utf-8?B?b3VwWjlES0toRkw4Vk9OazBiK0xGUnJTYkFCV1hKSjR2NEZBYmlDanVzUkJI?=
 =?utf-8?B?RU9seUJxTkpVY2RCZHpBUXVxd0tVOUJwYUhqcXI4N2hpNk9NQXZkK0dxVWlP?=
 =?utf-8?B?MDJGVUJKRHZaYnB4OXpGQkRaVjRwbmJJVmhPWnc1Z2xqVmZzL01nNXpHVjds?=
 =?utf-8?B?WkVkdithcTlCNTRCUlRKUkR2dGgzbFY3Y3BScFM2S3Jrb2NubXA5cXF4d3Zr?=
 =?utf-8?B?QzkrZTVycW8yRDY2VmJMOTVkbm90RTAwcGNQQkpxT2c2dEdheWNHY0JZNkhJ?=
 =?utf-8?B?TUdPSHkzK0FwS2x1TkdIOGlaUStiTmF1RUNjUUNRZmdlMGRkZTJTUy9yaU1J?=
 =?utf-8?B?a2ZaMFdYNHM3cXo5dzhxVk82U3pnbnZ1S0pvSnpPc0dJNUg0UnNFVUZYeFdU?=
 =?utf-8?B?aDBaN1paZDNlYStyTUN2WDdsZ1M5L3o1MzNKU3l1akpJVnhyRUZGWGdIbGdE?=
 =?utf-8?B?SFpITXVvUDExL3RzbnBVc1BHVFM3NGVlQkdQNmZSc3RGVi8zTEo5c3VIL0NS?=
 =?utf-8?B?VjVWUXhlSENUVEh4YTdKS0pYU0d2QWVIZVhUQVdZeWUycEsyWkJzWUhRYmdz?=
 =?utf-8?B?RXlEVWlPVnpibk1xcFJ1cCtVN1I3ZzlKeXNCdXhXM2lRTjVFdmFDcVZpMDVh?=
 =?utf-8?B?N0szVDVFVDFDZmNmdm1SSmxZMXorMG9tdTFTSjVqeG92QUN4Nk5sK1ZwOXhN?=
 =?utf-8?B?elN5dUxocFh3NmVTTE1GVW0vTjhIN2psOW1Td1NpVnJIdGU1b0lOY2pGaW5N?=
 =?utf-8?B?ajJSTkhJUy9iank0cUVpKzl4OGtWOGsvaVIyMVAxU3pxQUtZYXB5VHlGajlz?=
 =?utf-8?B?b1pxajR0bEhGVDViTVE2dmU3b0I3emFycDRDNE5GMDZKZEM1WktSNmVuY1R2?=
 =?utf-8?B?dysyemxlNFFpUk5Kd1JVOVlDMU5sdlZaejY5eUh3UFlGRVdkdFpoOHVXZDAy?=
 =?utf-8?B?bDV4RVN3TEJld3FrMkZGN2ZoVjdLSjJ6OWNJQTQ4Wm96TWdlVVJBRUpkZ1FK?=
 =?utf-8?B?T0s1YXl0UTJPdTJ6eEp4UEpwQStPUmR6dHNYZ0RWYjhjLzhJQVJMbkxadGRw?=
 =?utf-8?B?b2FOZDZ3c2JQemN3QzZ4NnpacEN3TFZHNGxqTWxMeGFPQlNiTWNDdnA4TE5Z?=
 =?utf-8?B?MGFORnJqcUhiOGM1c3dia25qMU9PdHdOWFpta3UzVU9tZ2FsSnQ1UDJUZVZX?=
 =?utf-8?B?YlJjOEgzU2RBRG5kb2owcDB0YlBseHJvK0djQ3l2VjFpclZYZStQUitBZlly?=
 =?utf-8?B?bWx6M004QUJhOWhQdWIzM25JSVlaY0xxWXpJOVIyRnJhM2ZMbi8rVzJYZHFW?=
 =?utf-8?B?UGJtblE0cWRtbFVJYW9JNFhnNEppOTlDVVZ3T3hpMlZqdGJXNFcwblpXclJO?=
 =?utf-8?B?aG04cEpLa2dDMVNabjNPY1lrWFdJK29ZcWJmWlFsQXcvN2NFYkRTUllraEhV?=
 =?utf-8?B?L3hLQVJEeEdvVEViQndYb2JISi9zUW16dVhzVU5CampvZUVJTm1raTdNeWdH?=
 =?utf-8?B?aXVRZ09RdlJ1VEw0TkZqVndBRU9NdzZGRHJMbU8xdlUzUkw2V0Y1L2JKeWFr?=
 =?utf-8?B?bDZpYmFWU2VFdjdNOHJsVFllVlUza1c1cWd4Ris4UGVpbDBBVHpzM05qMGFh?=
 =?utf-8?B?VUFrNTkzOEdONWVKQ1RtN2RzWjU5VmZhN3lWeitzMmYveDFKbHZJK1FRWUxk?=
 =?utf-8?Q?PKfMX3NE6BWSSuPv+zFGyPIaB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9bbcb4-e3ee-4d67-bab4-08de1131441e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:07:22.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDHhpGuhQDuQcgFjlRDb5v8mOQXMhWiu4xByD8iAr37Va4NJxV6n9lIzBXGn5jSfv7tS4sa81AvusYlgncIKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664



On 10/21/2025 05:44, Borislav Petkov wrote:
> On Mon, Oct 13, 2025 at 05:30:41PM +0000, Avadhut Naik wrote:
>> Currently, the NUM_CONTROLLERS macro is only used to statically allocate
>> the csels array of struct chip_select in struct amd64_pvt.
> 
> "... is used to limit the amount of memory controllers available per node."
> 
> You don't need to explain the code - think big picture.
> 
Okay!

>> The size of this array, however, will never exceed the number of UMCs on
>> the SOC.
> 
> Not on the SOC - the thing is per node instance.
>
Will change this!
 
>> Since, max_mcs variable in struct amd64_pvt already stores the
>> number of UMCs on the SOC, the macro can be removed and the static array
> 
> Please describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
Will do!

>> can be dynamically allocated instead.
>>
>> The max_mcs variable and the csels array are used for legacy systems too.
>> These systems have a max of 2 controllers (DCTs). Since the default value
> 
> DCTs are DRAM controllers. Do not confuse the reader.
> 
Will remove the *DCTs* word altogether.

>> of max_mcs, set in per_family_init(), is 2, these legacy system are also
>> covered by this change.
> 
> ...
> 
>> @@ -347,8 +346,8 @@ struct amd64_pvt {
>>  	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
>>  	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
>>  
>> -	/* one for each DCT/UMC */
>> -	struct chip_select csels[NUM_CONTROLLERS];
>> +	/* Allocate one for each DCT/UMC */
> 
> You're not allocating here anything. Just explain what this variable
> represents - IOW, the comment was fine.
> 
Will revert this!

>> +	struct chip_select *csels;
>>  
>>  	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
>>  	struct dram_range ranges[DRAM_RANGES];
>> -- 
>> 2.43.0
>>
> 

-- 
Thanks,
Avadhut Naik


