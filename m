Return-Path: <linux-edac+bounces-2693-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312449ED64F
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 20:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41C42811DC
	for <lists+linux-edac@lfdr.de>; Wed, 11 Dec 2024 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E7259494;
	Wed, 11 Dec 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WIBEpUO7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370D259487;
	Wed, 11 Dec 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944739; cv=fail; b=MddLwJ8AozUvLqH0MMJ+KoJtFZnDSxOG0VDqUQ3mVAQF3G0kTuEdiHZJ8IpXb7AsMiuPrd6IUdDQgLPcJPV6oKkZvBCFNZPFI6eyKzCMgJK6FOCfZyYpRTBvSGFajPB+D/pDQ3CYSjEiYQPqzPK4l+rwjAfSxan2MY36VE661Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944739; c=relaxed/simple;
	bh=04YTyNojeo6DRbm084ykyLCpm0Tn1FSYV+1DEWXwTP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckcbRx8KPf3mw2UQ/hHS9KPed4ORebLeX2XZWf8wukZzuARTOJLX0jQADLtH82lAErDJ75KbJN84juRnaa5DhTjSLeBe45OCcsa8Nj/aHFFZRLzLNjutZJw8huLxupGhrw4w5LoS5C0GALSTqKcpj9XZenNLy4dm0RgdulnHxDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WIBEpUO7; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQCsTXUOXEMI7H2jj4DWWztisMkgO05mzjgDas9/eUIibAvzJ7i6ujBd6LKwKJiFpWlRVs26aDpAMjRGsWgMGGiHpUpZdTzdjJqKKn2ijKpJN6V/YrK8i7RXQn+yjU+6rIkCilNEiER8eTcx8pVmGsSU1rt9LUHdg9HzkHfzba7ctXwvoiJOX6ldOF7nwVQvnEZyVehRdFTwC5v+1tAES6ZZ+0G4ThDId1pjm4XcauHzQixz1KxOUMKtFhEkJP8ffVdaKcNVQSe0OUXoMa/5XHl0kc4/EK+CySkoYaDoqYZl3PFFhIb2Jf4ZNZSAAErrK6X7JlhGUe8y/rRj6+rwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDh85LBIqQ0fHUnVdergSnsmKRAMKivCSXVX6oA5Mtc=;
 b=y1j+z+GDShqbhh7t1ORYGj45JEK3YRO0LKs7KC1lyaLF2JWpeNbkFI+jE74dPLUB39kGxyMQh/bcj6T0qcZzp8qw6OqP+SPUw7LRZw22dQ0nZe5ZtY85aW0ThzCwT9u5tJaIbJj/Xa7NBGpxS0Z0393lcz9SHUtn4vRGz4Rdi37BZ48JfPg0/rhMm/GdHhHYTZoiz4f3zAmMDp2pPQI9a818TtIVzc4VtqSijLqBX/uThMeMs/aRCbwz1gMx3yHzVu4LwhTu0k7E1+LmBP86PKyRumqtDQsDa3+mgkp732C0nhren5jbPBpiM8/RXU+mUP1DMvDT05aWOhGPJoNe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDh85LBIqQ0fHUnVdergSnsmKRAMKivCSXVX6oA5Mtc=;
 b=WIBEpUO7BSS2jK18e/AUyiRFMNs7cTp/87zcyO/F91bQZTV2F78qKwzmN9d47N/NzEdcRyoFEcCeCEvfxfqLebQl1CoD7y7unaE3a1RKwbtEQ4KZ1HW/dP/be/78pAbKH588Hve5StXrYlk+Qv54l/fMYbPOwitVfccHVo7jS50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 19:18:49 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%3]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 19:18:49 +0000
Message-ID: <28fb96f2-726c-4a86-a72b-cdfdcac9bce0@amd.com>
Date: Wed, 11 Dec 2024 13:18:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] EDAC/amd64: Fix possible module load failure on some
 UMC usage combinations
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
References: <20241210212054.3895697-1-avadhut.naik@amd.com>
 <20241211110729.GAZ1lycaGYmjgNDGv9@fat_crate.local>
 <20241211154637.GA1923270@yaz-khff2.amd.com>
 <20241211185109.GFZ1nfHQBJB4rdXXSI@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241211185109.GFZ1nfHQBJB4rdXXSI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:806:121::10) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: cd851255-4d9a-4abe-76a3-08dd1a18a40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUR4WU11K21aZisrcWZ4WkVYYjRHQW9xMU1CYWdpelZsNFBsd0pSVjBTcU1K?=
 =?utf-8?B?bkFwNWI2dm8zLzdPcHVvZlVSZi94Q1dEeXhheklpSEN6ZlM1SitZa1pCRktp?=
 =?utf-8?B?MmNrQkFFMzltMnhhOVgyNFBHMU9RR0hMSzlRWmJIUHA5dUVLbVI3UW5wSjl6?=
 =?utf-8?B?SG1NU3NVS09jODJUMzVLV2ZMZDZpaitmZ1Job0JGZ1RJelVUaXdrUUtDNzZL?=
 =?utf-8?B?S25BRy9sdGZ2ZGphM2RwVGsrYzZ3KzFCSnVqT29xdmNKTHN5dnA4c0xXbmZl?=
 =?utf-8?B?dFFEQ3h6YTBsWGJsRmNqZGRpajdsMWFDVzJjdGxDUjJzUmVNeEtBc2lmOGNv?=
 =?utf-8?B?dFEvYmxqZFAwRmtBbTYwM3JxbFk1UmE3MFdRK3lFbDR4ZHhSWUxiV04xWEJq?=
 =?utf-8?B?STlIbHJHWE53b2xCMEFSRExaYi9aQUpQRVZqTnVtTE5icVNqMkNoaDB6a2Fk?=
 =?utf-8?B?eVFBU0Q4anF5MHBhbGRSaERFS1F3V1J0NUhiL24yU0Nqbi9WUHF6NnFlZDND?=
 =?utf-8?B?WnRmT2hRaVdSdTJESFVSdXdTeW9aSlBBYWF3ZWNoOTJ0M3d3eUt1RFpyVlJG?=
 =?utf-8?B?cjVJK1kwMTZRZUhhUGFLODRnMEc3alREM1FoaTNmUE1YbmlWZlRPL3FYcmM5?=
 =?utf-8?B?Q2l5RlU1aFFmVGlVMlVxQW12WHpkUVVtZ2pGYS9idmZwbnN3cFJZSGxDYXhL?=
 =?utf-8?B?Zm9ZMFdyVXhKdWtET3JsNlpmYThIb0Vrb0ZYQ014Q0RaYUs5NW93cWt4OUJq?=
 =?utf-8?B?a0k1ZGhmUHJUb0dGb2Y4c21HMmRxL251blBuZ3d0RGpGQmNOc014Vjc3bXU4?=
 =?utf-8?B?RjJsZEJSK1VxejdZOWNMSk5CQXI3RksxQ2l4VElXd3JUaEloQ0swVnkwSVl4?=
 =?utf-8?B?aHJWSlVQcHF5aEZ5TlIySVVrL1ZLNE1sSnNtanlxNkNDbXcwUHd5UTVSOGpu?=
 =?utf-8?B?d053SGo3ODc3MFJrVk5NZDJOUE5DRkRTQkxCc2xOOHJCeHhHMlVHbzJzTlNx?=
 =?utf-8?B?OUYrY0JwOGMwdTlDWVQrQ0lHdXQxUGlNaTFXdUVlL0tEQkNyQkIxcGdSZ1Bw?=
 =?utf-8?B?TFZ2TDhIUWtFWmdOd2I5ZHZSTXFFSlIvcGxuaHgwNFovOTl0eU50RUpvajZl?=
 =?utf-8?B?UUpkMlFPSTZkUXljcTBMUnlqenpVaDg5VGYyL1loK0RKWmpvNzRBWExWKzR2?=
 =?utf-8?B?aVk4VEpjYWorVEZaUFIvOUFRdmlTazh2MXcyMWZ4ZjVjYzQ2UHhJcndnV3Vt?=
 =?utf-8?B?bEd1b0srbGYrTkl1bTJSQ2Z3MDNNcTArUmFMTVN5TWZMQ28xYTl4cjcva09k?=
 =?utf-8?B?N3J3amdIeGpIR2I1YXc1bllJZFFxQUlDV283anVHUG0xS0Yxcy9kT3VSWDRx?=
 =?utf-8?B?Y3JkR2JGZmhVczZTcG5hNXRjajJPMEx6ZDVSUW0yQWJxS05YMVp0ZFBKQW4v?=
 =?utf-8?B?YkxGaDU4dDhzN2ZZQmtpTXJlUXVneUczcG13bURhMW84Kys5VVdSTFBpSjlI?=
 =?utf-8?B?MTd4VjRBY3FRRnhqMHRLenE3WXR3OGJ3MFk4c0dYS0tBQ1JPbkxubDlBcmY3?=
 =?utf-8?B?cWJoMkQ1cWZTYjlVRkp4WEdCK2Z3M3MvNTZOdmEveUhtdmxhQ01VT2NsSk5M?=
 =?utf-8?B?S2JiRE5URjN3c1FRQlJ0WjgrTjZCbkdZalZ2WC9hQWtpMHFpVHBBWWdqVU1m?=
 =?utf-8?B?UjlxVStzRmFlQ29Lbll0UkpObExHTkJuTncwTkVDY1F4cEVaMWFjTFhHcU9F?=
 =?utf-8?B?aGFLdUxhVG9VZTVOYVkwTVJDT21TSkRzU1F2eU5TRzJ0dnVvR0pxSDU2bUdq?=
 =?utf-8?Q?dO11yOu7P1XdwtzmMifs9Jo1UZU62DDlzzqHw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVh1VE95U2Y3aUx6cEwzU1ExYjRoQXE2TTI1K3lBVzlKRnJYcEE3UEVSOW1O?=
 =?utf-8?B?M3RLTndCQW5wTTN5N2JlM2djc1BUbTRDZURsMmNpMmU3QmZBeXQrOXRtUmlI?=
 =?utf-8?B?LzJtVTVYbVE4cHkwL0dRQVV1dUhJdnhiUUNwUW9CZXQxRUlRNmhOVk1nL1B3?=
 =?utf-8?B?QnR6dWxObUlrdHZ0OC90RHhOMm9uWmlwZnBBUTdMZW9keklOVTZ3cGNDK1pv?=
 =?utf-8?B?ZDF0dlJ5Q0dCM2huUU5Nb3lFMHh4WjRnSXcxK1ZKaE9hRUNXek91QzlnNk5U?=
 =?utf-8?B?VDhqZFNxLzQzYlUzdkdWVnR1b0hwTENZWHBtSXkxZmkwUTVrWjlvZURzWEth?=
 =?utf-8?B?bFliRkNZWHJjcUZCMjJJT2RXOXVSQW5oNEpvK1liOWdUV09WTW1VU2NGdzV4?=
 =?utf-8?B?Z3d0S0x5V0lnWmlGVC9MbzgxYzZDa2E3R3RBQWVoaWxyck9ZeFBqbCtsQkNx?=
 =?utf-8?B?Y2hQUDNZT1V5TlcwYUFzU2IvcGFNVGp0YXFjKzZNVTAxNkFxU2tsVWJqeHZX?=
 =?utf-8?B?Y3FQN1VURVlwOEdMUnc3YTVIUFBjdTY4Wm5BZUt6dlRleEVHSmxrejBMZlBY?=
 =?utf-8?B?ZW1wN2NrYTJHR2NPaWk2VFVCRzVVRVpIelgrWFNMTDA0eXNrTTFBVzkwOUlr?=
 =?utf-8?B?ZXNjMTZhdUpaMlMwWjk5aGJvaUFqRURJY0F1bXNJWWViUEpNV0Z4QzUybDMx?=
 =?utf-8?B?RFRQMGhiNHg1U0xDU3V3RFF1SEpKT09RaVM3UHltM00wblNGOEVQeVhCdFF0?=
 =?utf-8?B?ZU0rQkV5ZmN6VmgrWWtPSmxPRVk2MXdwR1dZV0ZpNTRjRk9RenZhRmtmMDZ1?=
 =?utf-8?B?MlVwRnY5RVJWR04wcjdXeXhVQUY5MTBzYU1EakVyZHlvTnNHaU00V0VFZ3BR?=
 =?utf-8?B?cDZXZ09vQmVGUUE3Vm1wZ0FwQjFzVE1yUyt2ZnpESkxFODlqVFVtSzUxc2RI?=
 =?utf-8?B?eCs4R3o0K2NVUEI5dG40bmV6dUdQbm5FM0VTOHFTUGsrQ0MwdXpGRkFxaDJP?=
 =?utf-8?B?NmVSRk90Z2RwKzRnVUFUQ2t2b1NRS3NQdUJabzVUeUhCTjdjT3dxRjZDNG5z?=
 =?utf-8?B?NzJmSmk2bFl3MitRdTNJcWpFcVNDWHpROE5Ob0hJRmIxaTYveGpiWlo5dWtu?=
 =?utf-8?B?bHdYR1pzS1IwNlY1Vm44Y1lqRkF3Z05TVnhrb1hFSkkrcXhCZFIyWTZtWWt6?=
 =?utf-8?B?YkhBeUxFVS9SMHJucnpjU0F1S0UvTHdacVVyYzhFUXVXaWV6eFVQa0kxZmYv?=
 =?utf-8?B?YzdXelpCT3RvdDQwZ1VsTFg5bTZtOFBjT3pxLzVkbWFMRHRUMEhpMU9QNXh0?=
 =?utf-8?B?RlJsWjlMeFU5N3VTcEs2dDUwUTh4T2plOElHL2dxY3JrZEptcVd4NGNZQTJl?=
 =?utf-8?B?Tk0xTDMxQlkyejZIRWZmWkNxVFVRUGhtemExMk1PcEhaMUhEOU5zS3dpT1ZU?=
 =?utf-8?B?OE42K1pOTVQrc25GZUEwa1FYUUpwQmJpK3ZVSjZDWTU3MVQ5b3R6S0RBNitQ?=
 =?utf-8?B?dExWL1BRR3F1TDBDK1JYVXRUS09IbWRDZEtWWHZSbW16QjFJSDBwRkF4bzBP?=
 =?utf-8?B?KzZQZXZkeS85RnJvaEtlUjA4dmFaL3J0UVlMeGh6ckRuajZ4Y1dGQVJobGRK?=
 =?utf-8?B?QVRGSU5qQWpqcUxrcG5ibXU1dlpHWlNrdis4bU1XSGNVdmZFZ1JweUVIQlIx?=
 =?utf-8?B?S3c4MDBFcHU5OUlzNFpRNHo0WGtKczBUSS9IcGlybWZkaW5NNHh5THp4cWpG?=
 =?utf-8?B?T0gxZlVxZU5hcm1vdFovTnpTcTVwcU5jVXZGNlVwazVJMmlucWNVUHVkRlNp?=
 =?utf-8?B?ZG80RzF5dXFWeXBtbisvZlZqT0liK3NhcmRPbzlRM0lTWGdJaitIOXR6dEVU?=
 =?utf-8?B?N0pSSUFCWWRvMm5tWExXVkovTStjSElhYTVrd3pSaG9nZUYyRnRzTHR2bjRP?=
 =?utf-8?B?NnZDRDgvM1NuY21RWUtiMFhXQnE0Y3B0VjJBZG8xcDY1bzR1R1M2ZkltNU03?=
 =?utf-8?B?elpuRU1aY3RwRm9FSVhxZEpVZGFTV2ZOMVlkZUJnRFZadEVWWEpKQlh0TjU0?=
 =?utf-8?B?M3U1aXc0MU1iVVRmcmw5Wk4xVnUvQ3dpSGVnMHJvL1ZUMEFPQ0xSZFhtUy8y?=
 =?utf-8?Q?W2Vboh0HpbV9263xTY0nMshh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd851255-4d9a-4abe-76a3-08dd1a18a40d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:18:49.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2uVZoLcAQMAOeOK+auMJSwDecBVEsNIP2zP2if6biLlMC1l9XfMnVe6BInTSgPhwVKMy+hjZME6RYRYE4Kfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077



On 12/11/2024 12:51, Borislav Petkov wrote:
> On Wed, Dec 11, 2024 at 10:46:37AM -0500, Yazen Ghannam wrote:
>> Looks good overall. We can even remove the "nid" variable and just use
>> "pvt->mc_node_id" directly in the debug message. This is another remnant
>> from when this function did register accesses.
> 
> Ok, done.
> 
> Avadhut, can you pls verify this fixes your issue too?
> 
Yes, this fixes the issue of module not loading with some UMC
configurations.

If relevant, then for the below patch:

Tested-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

> I'll run it on my boxes too, to make sure nothing breaks.
> 
> Thx.
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Wed, 11 Dec 2024 12:07:42 +0100
> Subject: [PATCH] EDAC/amd64: Simplify ECC check on unified memory controllers
> 
> The intent of the check is to see whether at least one UMC has ECC
> enabled. So do that instead of tracking which ones are enabled in masks
> which are too small in size anyway and lead to not loading the driver on
> Zen4 machines with UMCs enabled over UMC8.
> 
> Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
> Reported-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/20241210212054.3895697-1-avadhut.naik@amd.com
> ---
>  drivers/edac/amd64_edac.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index ddfbdb66b794..5d356b7c4589 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3362,36 +3362,24 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
>  
>  static bool umc_ecc_enabled(struct amd64_pvt *pvt)
>  {
> -	u8 umc_en_mask = 0, ecc_en_mask = 0;
> -	u16 nid = pvt->mc_node_id;
>  	struct amd64_umc *umc;
> -	u8 ecc_en = 0, i;
> +	bool ecc_en = false;
> +	int i;
>  
> +	/* Check whether at least one UMC is enabled: */
>  	for_each_umc(i) {
>  		umc = &pvt->umc[i];
>  
> -		/* Only check enabled UMCs. */
> -		if (!(umc->sdp_ctrl & UMC_SDP_INIT))
> -			continue;
> -
> -		umc_en_mask |= BIT(i);
> -
> -		if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> -			ecc_en_mask |= BIT(i);
> +		if (umc->sdp_ctrl & UMC_SDP_INIT &&
> +		    umc->umc_cap_hi & UMC_ECC_ENABLED) {
> +			ecc_en = true;
> +			break;
> +		}
>  	}
>  
> -	/* Check whether at least one UMC is enabled: */
> -	if (umc_en_mask)
> -		ecc_en = umc_en_mask == ecc_en_mask;
> -	else
> -		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
> -
> -	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
> +	edac_dbg(3, "Node %d: DRAM ECC %s.\n", pvt->mc_node_id, (ecc_en ? "enabled" : "disabled"));
>  
> -	if (!ecc_en)
> -		return false;
> -	else
> -		return true;
> +	return ecc_en;
>  }
>  
>  static inline void

-- 
Thanks,
Avadhut Naik


