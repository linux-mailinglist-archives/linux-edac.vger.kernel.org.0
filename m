Return-Path: <linux-edac+bounces-4655-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB2B345A7
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4F2162C8D
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2F279789;
	Mon, 25 Aug 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1u512M3d"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742821FF2A;
	Mon, 25 Aug 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135442; cv=fail; b=Hq1xoWp46QCX12gfrXPy9/tvftaIarlLx0CmIQyl3LhJa7DeUvJJPj+mgjLmNCMVD5Wh/sCYf2l2H9VRiSiJZu/sGXYx44ohEnGvVvAyfVPm3g6ctpCQtSNDGRkA05Ik55kfof1vMdpl9cdPcTTJGw23x+JXw4YJiZiR4xXzGfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135442; c=relaxed/simple;
	bh=D+ckMoacOKwnayv8TA72Q7avkpRj/TrDn3LTqzzeX0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2C4cjn2b/bEL+ra73O5oGGhS6An+Gf/9QpkpPP3L7FC0sSnEa/8c8/W4iiyB+AHy9kAFhR0nraQ0fXpUAsIlhiCDTKGMmozCSjzyA8SJzm6d6lZS5O1wJzHsGGOpp2TSds12SW177pUSOgBJPESrscTQfKBSsb4QMoqjeq17TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1u512M3d; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz++OLZZyHb7Np4xiiO9ABcI6FaHqrKmxEnnnDSIlmI7xMrjYkWpB8EXmZGdhaMfZJJcnoS9kt0lrvtCKaGsNR2ZVEcGZ1hjAxN4RPuyIsB4I59R+5f7hekfASlDPzrvw0eR6jB0784Do0ckfDq9V5jERRR/blThaMvSIJy5BaIoxaZtLDwhR6G49kMTf8j6DI3LR6PfXlnyZpKisbWwMHQA6PqjEl+3T26ADDRVkDL8qabgxOewcD7cceAY28pPGrvgMA7gfnaXlFt0OnJoGhYQlCrg9GXU4gbFkx9UEY8Zv77R3V4cZpiUaPCxA9PltfajJbyRFgXbzHT0c2cCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh98miuZjMxNiMUhs6gCrXSEf4l9VW0O4HbQC+f9/ic=;
 b=ubZt6gEvL+QJV6RJKTyyQKyBs2w5oJGv19OOCqmFbdqU/S8dB8CiLfkiIZBMNqcwknK91jftNizIyeMTqtlsUdJT/g+Y42zQugQ87lCJhuU/6IIHD0JBdyeWBSgJGVh1ESh9SJNHA8WbevZ6VKE103LCHpllmdQA7jTzrjd+/8n/J2urwwbReRaiSw6VCEr+BI1TJIokzw/0j7wt1K7eMJmjUGFaUG3xMTgo2QGkMhbbT94XoG6hp8IMuTZFZXDEwFLstXrmEKNUexvw0NYLtiGMWsYWQOi9uO5097mziavUO0c3+jIsf1nvODM0Q42Zcna8XSbtthPMTfhoflCA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh98miuZjMxNiMUhs6gCrXSEf4l9VW0O4HbQC+f9/ic=;
 b=1u512M3dva8SshqnfLIKl9bVTROCoU3/+ej9chI2a7od76lsfaLY4RKiBL4qriWNEsoXWRzvQudxtBnVUxzi/23hf9josBZZqass4LAK8fwhGYA43FqdOn2PuB6nqQVLypg4ulc3a2GxeNOrFmgYGFDoJvE9RHOa1pdOj/m0WmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 15:23:58 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 15:23:58 +0000
Message-ID: <3dccf0ad-3cad-4211-b01b-c3f750092711@amd.com>
Date: Mon, 25 Aug 2025 10:23:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Add support for AMD family 1Ah-based
 newer models
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
 linux-kernel@vger.kernel.org
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
 <20250807201843.4045761-2-avadhut.naik@amd.com>
 <20250818212248.GHaKOZqGhfCciWWOcD@fat_crate.local>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250818212248.GHaKOZqGhfCciWWOcD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::7) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: 89915a09-1eac-4ca9-366b-08dde3eb6972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWtLWlBaODhWcjlURGwvMVNnNzM3aFNpVTJyWnllb3VNalNoMkVtcUZOOGNU?=
 =?utf-8?B?UzZ2VHp4Rm1NNFFkSEJtMU1pWUFTYmR2RXgvSzFYZkJQN3lOMGlMY1pVNkJF?=
 =?utf-8?B?MjExTkU0SFN3eWZ4am85ZjJ2WTJackczWm11RnFZOUFDRWVLRWtqQVNqTXgv?=
 =?utf-8?B?WlczNk1aTFBxdmZCVzhyRVNtZnlQc1dXZnVmdGhYcWtUVXBma3YvSEl3elkx?=
 =?utf-8?B?NnpZcnpsMmRMZDhFRmNySGNmMTN4ZWo0VnM5VEtjZkFhcmVjci9QR3lKQnJk?=
 =?utf-8?B?VTJyMThWbGFQNUpKWkcrNHJkTDQyakt6MVN4VG1EdHZyS2JRSGV6S0lpeDJ0?=
 =?utf-8?B?TnprVWU0RlY1SjFhU2hubU1HRktlZU1JUW93dUt4VmR1Z3dKbGVBLys0d3NR?=
 =?utf-8?B?N2YyT0RabWFhMUlNTkxURzFoTWxYRWZ2clJoZ1lqQUZtc0xaYWNqL2ZxaVh5?=
 =?utf-8?B?NUw5SXZMWlBGQmozNlhXREtNRDRBaFA5SUFjNjFpMDBmZUo1MExWZTJxNExD?=
 =?utf-8?B?M0MxbzBGb2ZMczJtMVA1aXNLeC8yNGxYdE43clJ3SERJS0lGbW1aZ0FnYVFJ?=
 =?utf-8?B?Q2l1SjY0U25QTnRJb3g4Z0NFbUxkdFdxS0xYYUVkdGlKTURxTFJTUC9nb2dx?=
 =?utf-8?B?SUtnUE5nL1Q0VnRobGtOWTNEci80c3JpMjZMQTJaMFV0RXRXc3ovRUtrUFY5?=
 =?utf-8?B?R3N4cUU2VS9iTW5pMmExS0tMZEdGVXpXWExJQXlFRlRHNnRFd3hEeXRWcGlo?=
 =?utf-8?B?WGpEbDNaRHk3My9iSWp4YkhTbVFRTFhMMy9lRFhQSmFCUzE4dzNJY3JDdWVS?=
 =?utf-8?B?a1hRQkdXdmtjVllwSU1YMHpoS09HbGZtdjZpOVZUb0JsWFV2MDhJVWxmaDZ6?=
 =?utf-8?B?eEM0bEorb29XSTFxOTM4ajZYM2tUT25uUXRFaVg2ZVAxeWg1UDBKcTBxZFRN?=
 =?utf-8?B?MzIxSVU1S2ZIbmFoVElVY0xkZjU3MlJtS3FxSTYyUW1ZUjFtRXlZamJoSHBJ?=
 =?utf-8?B?ZFhPQXZOYy9MWE1CY21ReVZZS0I2bzVad0tQZ2J1YUpMa094cjZPYUpjSEFm?=
 =?utf-8?B?YUNBNmlDWjJEanovV0ZYclFOVFVhRUMvRk9TWjh5QnpSMHdqazd3OG5VSnA5?=
 =?utf-8?B?ZHowa0ZHaFRWQWlxMm4xOFpGS1dlN3BOWVdxTGVnayt0YmQxdjVOdkxld3h2?=
 =?utf-8?B?SXBYejVmTDhGSXpPYWo0dnVJbklGRFBNTkl0ZDdYa2VqNzd3dkxrQzNKaVhz?=
 =?utf-8?B?cDFyYnpUNnRQZk5TNjNSaW1yUUFhejBKK1hmV3lHQ0NrdHhUNXpxUWhPQ0N6?=
 =?utf-8?B?YlhIQXFmbDk5OXJoSnV0OWtLRnNXTnIzdjBYVCt0TDVMY21mRTNzVVk0VnBw?=
 =?utf-8?B?cDlOWURvZ2dNRStabWdMR0dQOWY3T3AzWVV6NkFvNUNaZ0F1UGJKdUt0bEV4?=
 =?utf-8?B?QXhCZVBWMXFRY0VDd1dCaFpYYmkrUXAvL3hUQWtWd0FIZ2FKdFoySTdzOXBj?=
 =?utf-8?B?UTFBRDRoc2tnN3ZYWnhwZzF0SnE2Yng4bHFSSm81aHhyWXBnZU1NbUd2Ly82?=
 =?utf-8?B?R2JOMFNHQ2pSZ1d5b05ZZmhCTERrUVZNcVlENFFIU3Y1elBDM1BTRDh5b1lm?=
 =?utf-8?B?Zm5uOWZHNWNRYXJpUStjWlpUVDkxZWhSSHlyU294R1V3TGZLZmV1S0lhTk1K?=
 =?utf-8?B?bll2RHp0eTJpejZiWlpWT04wbnlWY3FmOGFEWnBaT0QybnVpR1Jpc3RyY3k3?=
 =?utf-8?B?RG5vemxoSkIyRGRQOWVQMXpCdVhSSHlNWUVZV3RndU40cjVnQVd5T0tHZU5k?=
 =?utf-8?B?OGxyTWxpRU5BWVlQVmpMNG95WEFobklBcXRPekFtNFlqUzZiTXlpb1dzdWxa?=
 =?utf-8?B?bmlPS3NjVEhjMjNyTFQrRzhMeG81VW1HQWp0cFpXZENHN3l0emtUdkUwSFZL?=
 =?utf-8?Q?Pj+pNj1KcbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emoramxqVmRlb2ZuSlpOaHJ0VEFlMDNnZE1RYzBhNzBaVm5qTU41Q2FXOWJ2?=
 =?utf-8?B?QTljVHJqR0QyUUhTSmJUYVBtMmlsRjZZU1liRzJIQU9NUW9tZHN0OEVaQkRr?=
 =?utf-8?B?bEVGV1Y4K210bWl2S2JwREtGdGJrUXQwYllUczJaUTltYXplRWd2aDBQT0tF?=
 =?utf-8?B?Si9JQ0I2SEhLeWE4aTZkOWdHVDFPR0N2emczb1FwMUV0czJVNUlsbEFST08x?=
 =?utf-8?B?S3l0QVNwcnZjT25pV3FVbzRVeWIzSkl4RHRkTTh0MGc3UXhZZVc0c0dtdjd2?=
 =?utf-8?B?ejBFYUlDVzlSbW9xLyt2SmowVmxqNnlVRzgvT0FqQWsvL2F1NDZCdkFvdU1r?=
 =?utf-8?B?VlVPTmJ6RCs0Z24yZ0U0WndVZWVUbFpvZHcwMDkyV1A0a1pYQ0RDc1BpSFBl?=
 =?utf-8?B?UmhIQWJQK01nZTU2K0c4WGFuRFJ5cHVrOEt1TVlSZXVnU2RnbzJDQVlxRXA0?=
 =?utf-8?B?OTIwMFN1RVVmbHlOdlJBbEZ0WTRHQnNtdnhpcXZWZktVYnRQQjBsbzlFTlMw?=
 =?utf-8?B?bnp2OXo4bzFPNDlnUVJZTFVSTS9qMlRGKzRRc2FMM0EzNXhpSjQvVGhoVjFs?=
 =?utf-8?B?aDg5aWVIb2ZRZnZaZ1J1ckNnSzRWTERQUlFWV2N2Y2cyNEFQMlVnTnNSZUVD?=
 =?utf-8?B?NGw1Sm95b1oyU1FaQlJFNk1OZTNVLzhLOWI2VVIvd3E5bW05R3JrdnlHbmNZ?=
 =?utf-8?B?d3FqOHF6bGpSUGZyd3N2Smc4UHVBbGNUTWpxcVRTMUJvNWloWThuaVZ3Vkhp?=
 =?utf-8?B?WUNNeGJMYVVFVFkvTkVSKzZVYTgwS283WFBoNmFSRVVwYm9TakdXUUJMTmVy?=
 =?utf-8?B?WjY5R3BTVmluYVF0QnVTMmNuQUlZNHh2dExRRHU5ZlArNHltZG8zNEZGVEp0?=
 =?utf-8?B?a2dqT24vNEVibHhJeHIva1g5L2V3MCtRWlYrWm8wSmFNMkxjY2gyQ2U3SXZu?=
 =?utf-8?B?a1NQU0Y5K3dJQ0JjUk4xQ1RxQlhiUnFxanBXWXREeGZxeEVIVnlBYmZZeGd0?=
 =?utf-8?B?Q05IWkZGVWZuUnNwV3BCMHg5K2xReFFOZjBtcGhEdVlJSnN1U1B1WnppNmFo?=
 =?utf-8?B?SDVWN3ZZQ2h1SVNhamluWk55VnM5QVNCVUlGQVZYT3REYWdJWDVzbEJteWdY?=
 =?utf-8?B?UERacDREcnNKdFlycFpuTnNaSmc0Z0Z6eDkzV3N3Q2xBWmFXU1BubnQ4ODRa?=
 =?utf-8?B?N1BKU3lGbDJRazBnbzRKVjhURmE3SzFOWllnb0Z4SUhKcitrOHpiNHJVeHo0?=
 =?utf-8?B?djRLLzRhNndXeWExL3dubGpRcWE2M1ZVTU92Yi9WWDArR2hxWS93ZmdsSTZG?=
 =?utf-8?B?cG1uZW5KQVZpZG5Pc1FhK0t5dGlUOFZtMlhnREVtcysvbFlEKy9CK3hsYzdl?=
 =?utf-8?B?OXptcXpxaHM2WDNHOGV3ZTJPZXowSkJ5MkQ4YVpiMWtJQ0tlMmdWYStyYmtT?=
 =?utf-8?B?dE9vZmJzSXpwaGs2dFFKSVQ5eFo0ZDdVekwrUEZwN1VkclVjYzhWWXZtNVda?=
 =?utf-8?B?TUhmczk4UW1UUzgwbDlYY2hMb2kwUGtMYVRES1BDcUdPeTJ0OWNja3U1VWNJ?=
 =?utf-8?B?VjZEakNOTis5SFNEQlZkZ0U1a0hDcXJ6TnVBdUVpaE9KNVBFUitNTjN0MXFz?=
 =?utf-8?B?LzZRb255RU00NmRhUEZzWUg0dklZODlGaFZEaGdUNUMrMkozS2hmYW5RRVZi?=
 =?utf-8?B?TGJXL2I4YzBSbUVrOFlFL2FPaW93TTF6VHVjT3hiZk5tci9xZ2ZTNTIyUGxL?=
 =?utf-8?B?ak96cVFKZ1Vjd0dEdDdUWGh5dGVVTlpoa3NQQUhkT2R0ekFNaUZ6UjE4Mlpy?=
 =?utf-8?B?K2ZHSjVJdFp4aWNoc0xrcDZ1ZXBvSDRwbi80bEk2WVhxRE40Z21YYUhLa2lv?=
 =?utf-8?B?WGRGNk9wc1dRYlp2YXRWMkpkejA3akJaQUJJOU04bzJINXNRWGhXcDBaTWZz?=
 =?utf-8?B?ZmxEb1R0dnNwcWdUNkdPalhaQmQ0emtiNEpsQlBLRldrK05DR2NKMXN5L21o?=
 =?utf-8?B?WE42T0FTOFQrUHRIbHgwQXpiN09nSUNjTWxYekdQYnRlcVZER0VLcnAwMTZt?=
 =?utf-8?B?VFE4cXZiY1FhSmJ3cThHSUd2V2thWXNjYVl4d0lIamFVZ0lFRm1XYWJGa3N3?=
 =?utf-8?Q?C9w/+ayTjKncrpsOQ9M7q43/e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89915a09-1eac-4ca9-366b-08dde3eb6972
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:23:58.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxthTRU9+moVVXak3gMlld+jeDrk7qLB0Tme9qf2ItpM3px6St1BXF0kwqTSdlW7jbccvD8Miha3mdBS5L7yZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387

Apologies!

Mistakenly hit send early in my previous response.

On 8/18/2025 16:22, Borislav Petkov wrote:
> On Thu, Aug 07, 2025 at 08:14:53PM +0000, Avadhut Naik wrote:
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
>> index 07f1e9dc1ca7..2f6ab783bf20 100644
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
>> +			pvt->ctl_name           = "F1Ah_M90h";
>> +			pvt->max_mcs            = 8;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0xa0 ... 0xaf:
>> +			pvt->ctl_name           = "F1Ah_MA0h";
>> +			pvt->max_mcs            = 8;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>> +		case 0xc0 ... 0xc7:
>> +			pvt->ctl_name           = "F1Ah_MC0h";
>> +			pvt->max_mcs            = 16;
>> +			pvt->flags.zn_regs_v2   = 1;
>> +			break;
>>  		}
> 
> Oh boy, this pvt->ctl_name is ridiculous: we're collecting a zoo of string
> objects where this thing can simply be scnprintf()-ed once at driver init and
> then the pointer handed in to mci->ctl_name.
> 
> Something like
> 
> static char *ctl_name[MAX_CTL_NAMELEN]; 
> 
> or so. And then
> 
> 	scnprintf(...)
> 
> into it based on family and model.
> 
> Can you pls do that as a cleanup upfront?
> 
> This is slowly getting out of hand.
> 
> And then you can group them together:
> 
> case 0x50 ... 0x57:
> case 0xc0 ... 0xc7:
> 	pvt->max_mcs            = 16;
> 	pvt->flags.zn_regs_v2   = 1;
> 	break;
> 
> ...
> 
> and so on.
> 
> So that this function turns back into something saner again.
> 
> Thx.
> 
Will try to put this in place and make it the fist patch of this
set.

> 
> 
> 
> 
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
> I've asked this before but can we read out the number of controllers from the
> hw somewhere instead of diddling with this silly define all the time?
> 
> Thx.
> 

Had considered this sometime back. Didn't pursue further as it maybe somewhat
tricky.

Some new CPUIDs were introduced since Zen4 trough which we MAYBE able to
accomplish this i.e get rid of the macro.

But am not not sure as to what we should do for older SOCs in that case.
Zen3, for example.

Will look more if I can find something else.

-- 
Thanks,
Avadhut Naik


