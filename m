Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3DD43BA01
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhJZS4B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 14:56:01 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:38913
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231592AbhJZS4B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Oct 2021 14:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN1JGet1aaI/NJ5vkN8BXHf7m9swMN/27S6SYx/VsPioU9ZORfENWQjlut3VdaRUJqCHqEmnYFtUWGTiDDjt55FdEt82takp0T4Dp7vk0Yb+kizQAZFUjjYeA6btRDwF+SMOvzwZtnwN3ifcgvOfmnaKFBbW/DnueKIC55nTXjE05M+vDNzVs8cLHb1OiewpORQ1VLpVHCCuvspknI89m/F8clamK9E6OT4qlaM7fz0xWQZLgopmFzSn7q7jAwC/CLldbRbW4ICbtQknV7ijVlqDKUzQOt8Ux92V/UEWD7jrL0v6j+hHyJmntmBjnpeZIQU5ErTtpPZCqLCZQC0wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo+NFh4RPNpEJOqJhSQUZ/OkziDomuyEF45lEJD8w9I=;
 b=SIPbnwFLIOWK4ew1nywz3SQV5WXNFKH1mJC5zvQe3Hs6iEY3uUfRVQPf0Sl93rx9BxnarrNn9KONR4Y9pf/Jx7sicRtsTas8VKTjAEeWyF+5kFJREPpja/O11gOuL0GU6t+sUOT8UL39ArCV7MlW5bw0VIG3UtwZZG4+WUWbhlGJdqvHYBk5pS76BHiOtx0k3P7erZb26qM2zusbfnQ87n20ac+YsEkXNIaB4t5caMbxvYgvz96zWqZIV02AXlVkYYXY9dvXawK/lfCGEGNnkUuuhnXeO6TE7BXGDk7N1gbaL9dNlcoso1KVVBiXTAKMLTDF9rbHIffxp8B8/63NUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo+NFh4RPNpEJOqJhSQUZ/OkziDomuyEF45lEJD8w9I=;
 b=SjIoc5W+Io3YGO4hvBOyS8dkOqTKsKbyBSw7td0zg/VP+Of516sqyBOn3Kc5uef0cXPL07rQ7H7jbVmtOSGDe7wxZi3Q85Vf1tjvwO/lfSGr8yf9YIkTc4iFO1Wj6U9nSsZpe1y0YbzFJSzOScVOYdUJD6n+xBSEHn98DMU5FrE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 18:53:34 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::758d:1b96:8338:9f86%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 18:53:34 +0000
Subject: Re: [PATCH v2 2/5] x86/mce/inject: Warn the user on a not set valid
 bit in MCA_STATUS
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
 <20211019233641.140275-3-Smita.KoralahalliChannabasappa@amd.com>
 <YXfSGW1i5dLsiX84@zn.tnic> <00f4a0ab-f241-6674-f37f-623f3d9a8337@amd.com>
 <YXg3rIump+CAtgs6@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <73439c67-b7a3-e43d-511b-86f4a314fa29@amd.com>
Date:   Tue, 26 Oct 2021 13:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YXg3rIump+CAtgs6@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:ee58:7bdc:9246:ca14] (2601:647:5f00:2790:ee58:7bdc:9246:ca14) by BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 18:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13be35e8-1360-4131-4ae3-08d998b1e97a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2615:
X-Microsoft-Antispam-PRVS: <BYAPR12MB261586C2CF17E1D8ADAD7A7A90849@BYAPR12MB2615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jODtOX3gFtiVu0zaMfpQP1Z8BFotPa2nseYYd5ob3SUpnKF/wHu0rEneQRysJpoKB5RieLrEk5UFeEZwkyr9nbtU8Ui1HjfVn4biy1BkIAGah1OQcoFmLCDMZAwF4G6BrDVnXPrwew8Oo6t/IxqZ1X4ByUCRkONmlUHSKqNAEfauGyqVu6Z/zBW8Sv/ruAYmdMOFuxCwOEpByKRV1hjRf11KvAIvzdvKeVHVL+W4teNs4whg5l0FzoeeL9q0kTCOgywXxCf6ZblZ+Mhg98Nx4gVJjajBAM6IEvkFB+wXpTOGxHNY/KP/oJUzK3MgR+mbHigCKvL9n+L8R52oR9RbOyG6nwocXY+PPIy802GUk2hanT3gOGDlTnuYOT46AGB8RR+Od+vjVKohLHBLEFaRJuhRQGHtYx0DEGxOeDPzwEKhCCzc/meYb2/fOjb6Vw7Pq6UmtybrspHTWTFyiv7kGSGnIQrRn/YuPX9jmwQV4TtWglOi0YShnAAUSdGbeFYR9iOcliuYI9j1vibX++VoTr7fdTV8SYzDkqwy8NZTBgOstYYrQcEyJ5G1SAbIRX4OOXFmusJku/16h446ula/Xuc9cWvxo/Wp35j6IhmDI7UC9wZqspvsWAglE15vNVXZZc3Y8bWhD5bdHcuakT+sb8U1qiefE2yySqZBZ205VeHZOPLkc0ODLy/YW10JzvIdErw0M2xiJVeJGX9z+b4rwMSmrKY15QV/xaZuQYVp8Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(8936002)(4326008)(53546011)(2616005)(6916009)(38100700002)(31686004)(186003)(83380400001)(6486002)(31696002)(66946007)(66556008)(66476007)(54906003)(5660300002)(316002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0MyeU1kSzlTUGk1cmJNZ2dUdUV0aUY2NmpseDVrUDJ2ZWN1azNENFZpaTlv?=
 =?utf-8?B?ZUJoVnRZVlJmSWJHYXRLYjBEMDgrYlROYjhHc3J0MG15dTJUOEpRT2FmU29s?=
 =?utf-8?B?aEJneC9aR1gwWFl3cTNyUi9xdUZGTzUvNU5SaEYrVjVrZ2Z1TGYwT0Jidjcz?=
 =?utf-8?B?a1d5R2YxdGN2czNHQlFvK3NIMW9Tc2dOOG1vUmtDTVM2U0tKb3pHRDNGU25V?=
 =?utf-8?B?V3pUc2NWa0h0bmNlU1RPeHlKMUk5enJta05aenhSY2dHL0NwTXQrc2FYSWtZ?=
 =?utf-8?B?cVBxaXFBK0kyb2xUdDJwa0pvckJVZ3hYZnJaR0JoVFdjb1oraWsrSnJaTjZY?=
 =?utf-8?B?NzlkME5ac0Vwc01MREMwQk16M3phSFNlbWltYVFvaDA5Sk5rUi9STmdpMkFh?=
 =?utf-8?B?QkI1dktJbGpHc3NBZm53WVp5R2lHa0VvMmhqMXRXMVBXZ0gvL2N3aSs5V2o2?=
 =?utf-8?B?RkNoY3RpQ0xaZHhEYWRQNHBZSDZxd0QwL0RoQ21CKzYrSVdqVStJSW1zc3JQ?=
 =?utf-8?B?MC9kTk5lbXd0RnJXQk9HM3p0SUZmbzdQMnYwcUwzOU1oeVZ3L2lGcm5ON01O?=
 =?utf-8?B?RXd6cGpmbFBGUTQ5V0ZmNGxSMDBSY0NXa0Fud2tZajVDUWdDOStvWnpvcEJo?=
 =?utf-8?B?SmRpaU9Hbno4WFhtRW9qV0JtMXRNeGhpd0ZCZmFsZVpuSUpmelU3aDd3Um9r?=
 =?utf-8?B?MVRsdjlIVThXS0hmdFhmNEkyeXl0L0FKbFJRcmpzdGZvV2w5QmNia0xlSVdU?=
 =?utf-8?B?MS9sK3JWeGNsWWZMTGxNdlZmK3VhbHhUdElIRWcyTVlHU05MR21TbWNhbFBp?=
 =?utf-8?B?UnJwTHpJR2kweGszOExhUXljd3BXL25JbzdiUXZPbGcrQVpuM0xqSmhhSS9W?=
 =?utf-8?B?ckU1MG1haEl0Ym9tWVoza3VWMmNHMGhlZnhHbW9DUHVPYlQxbFcrM1dqd2cv?=
 =?utf-8?B?cTZjejB5TnppOVpWVzM3L0dFeHVOdFNBYkd1Z2dhaXk5anhzMENNcFRyWWg3?=
 =?utf-8?B?QmhzMHdiSUZFdmdhWEFOdnRxay8vYzNwUWJyQkt1NEJQTFRpck1JelJpQm5w?=
 =?utf-8?B?STBHcGVldDNQMUdPVlRWQ3hjR05sRnc2ZGZRdlJMQ3UvalJXZnVvODBCT3hK?=
 =?utf-8?B?RERnYXd4N1JKcEtkUUFsV09GSVkwMGJSb2h2eVo2SXZoTEdNbmdrQmNVQU43?=
 =?utf-8?B?ek5vYllYVVdyeHhuVlJQRzVqbDNwRXJFbU8wMTFXUzN1djhFMFZWREZoUUdj?=
 =?utf-8?B?MkNUa0dsSTZCZkV0SEdHSVAvSjBvMzR1WktIa2dDK2xKZ1ZnMW1JUFl1a1FI?=
 =?utf-8?B?U1A4UlRSSHBHUVlEOVhTUllrS2I5V3lCTjhJK3JScEdXYmZNRkM4V1ZMS25I?=
 =?utf-8?B?dmJWMStVTEYyakQraUxlYmU4dEdoZ2JDRzVUaWtEZlVRRmV4RnpibHB4ancv?=
 =?utf-8?B?N0Izd2ZYNC9wekNqVC9NNkRNL1pIOFBrN3NjVUxaOXZkaUQwMnR1MVlrcWFM?=
 =?utf-8?B?N3RxTi95Q1RVeFJ0Z3Y4aEJ0elRpM0VhM3VoeDdWdTNsWEt5T3JnSGpnck0y?=
 =?utf-8?B?VnpHRWFVWWIzd0dobU5tSHRUemdqaTU0Z1dWUHFibENtTUQrSjZUNHF1b29C?=
 =?utf-8?B?bjVSbEcveUt2ZWkzOTdGRFI1L0diZVJWYUtYbGU5MFZjRzNtbGVuMzBOY3hy?=
 =?utf-8?B?UWdDVjN1N3Y3V2ZkYnArTXFPZXVvQWtjdGdXZU5qZjFCblVpNWtsWU9GaVRR?=
 =?utf-8?B?d2k3Z3lKa3RrUEtQWGhVQnlHVlhrUEhwM2EyOER0bTNMaVdTMlhvQk9tTzRQ?=
 =?utf-8?B?VnNjYzczU2NiK0o4VTlwMXZtMFE4UkozRGhvOVc1TFJvTEdDVTNqeDE4TEJH?=
 =?utf-8?B?TzM2YWlFY1NJa1MrUTNmd04yRVZQSzZKMFBEYkx0aVZTVTVXNXJMZytuaGtP?=
 =?utf-8?B?SkU5UEVLaVY4M05nSFZuVmlaU0VWaWpyL2UyM2ppbWhLUFdrZVRVSUZra3hU?=
 =?utf-8?B?Nkc2MWN5MCtQVmdJQ2JQMmFpU3ZEbHlySVFyQjV6TVpZWjBacG5OQ3doekVh?=
 =?utf-8?B?OHN1bTEyU0FGekQ1THRBOHJBNGVpYWtvQ2JMV2NBTStRZ0t6R2tuYVJqWjhJ?=
 =?utf-8?B?b1lEdWVmV04vVjkyaGpuWDd1cWZ5V2lTZ0FCczMyc1hPTmptOGRLS3lNQkRw?=
 =?utf-8?B?Nm0xUlZLa3BoVzBRaXlHV25wZXFhZUhnRklkMTJlS0VjWkJBb24yR2RGam9J?=
 =?utf-8?Q?Cx4RFyQRJWErsUhoQEBdWM3ZhcSdRzvJlIuFQV139w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13be35e8-1360-4131-4ae3-08d998b1e97a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:53:34.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgq1MDspP2ODyWddykNsmPiIM5r4p+JuH7cO0dwVdN2nW1ygpvowCE9sSljGNGZYcEr2f+n8RH2UhdPGUCJg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10/26/21 12:15 PM, Borislav Petkov wrote:

> On Tue, Oct 26, 2021 at 11:58:58AM -0500, Koralahalli Channabasappa, Smita wrote:
> Whoops, sorry about that.
>
> So let's analyze this properly - there are two cases:
>
> 1. warn if VAL=0: what does that bring us? The person doing the injection
> will simply have to set the valid bit and repeat the injection.
>
> I guess "maybe the user wants to inject with Val not set" doesn't make a
> whole lot of sense because nothing will happen - error will get ignored.
>
> So we can do all the warning we want - it will be useless and in some
> cases the user might not even see it.
>
> So it sounds to me like setting the valid bit directly makes a lot more
> sense.
>
> 2. Automatically set VAL=1 to correct any VAL=0 injections.
>
> Yes, we force the VAL bit to 1 and that is not what the user injected
> but the user injecting with VAL=0 will get ignored, i.e., it will be
> pointless.
>
> So we "help" here and set the valid bit.
>
> Anything else I'm missing?
>
> Sorry again for being back'n'forth on this.

Right. We are correcting VAL=0 injections made by the user by setting
valid bit unconditionally.

Not a problem. I could have broken this down in the comments before
coming up with this patch.

I will make the necessary changes and set the valid bit in the next
revision of the patch series.

Thanks,
Smita.

