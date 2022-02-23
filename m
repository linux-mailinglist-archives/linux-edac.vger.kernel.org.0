Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE64C1E6A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiBWWZl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 17:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBWWZk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 17:25:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CED73BFBA;
        Wed, 23 Feb 2022 14:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4//fq/5pUCIJUqLiF/9P/ezEMJDHqdfeTqPCg7Uivdc8bCfpX/G5hyafSfg0JIXILCjo2wqdsA5gdy3vSFc0zZcJi7G3Vk5KqwFLYJxiZQDQ4bM10TAQ6qaeuNzfsIPxUxRxfDiEQ3egtnotoFaYHWgRvngBSlBlpDhsNcodiY9qXcynzZTJTYhSS3p1rCOfwZ7SUgVRQ0/Nc2uc0JktniYIyXGvQQayuxXHAFMTuoB6HLxv4hJraLNDGtu5mckRCevj+kD3/TNUVN3HGXByFFz5qShHKh2fAbhv322CSALhev8VZOM2bbDeTx49lBGAngso7NOPW1ZhK82UKfCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQXr8J2WC6iJDrOorIciss9Pcodub25dVZq+MLugPi0=;
 b=aKvyNRHudl6/LzOojqyqia79H2Z0MV76DuD2nNWaMke9qvViXl88R5G7rtshKkA9d60LGpFCOz6qBznVTDJ9VQdG9WNxEy12FDT556om4iGTqP4WAHiqkxQpFLSZovHfNYeGIk5I2ZgMZbUy2NL4TJ0HPqth1mfEl3nqTyi6YWCBSx6MYAne48HsPKkX1HvJTiDGsOMKOMp5ktwA2809B+wa/BfV9PUAqTg4qSIoYyKyqby3a+kcyXWo7dhAiRaNOtLe6M3NXmorSO9D6ChQwGqiEam4BmuDH7tUmXzIvBsARybl+4aX5G+KenONQpn3RKXvWiXaa72IpxN85ApYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQXr8J2WC6iJDrOorIciss9Pcodub25dVZq+MLugPi0=;
 b=wSlYBCvbONz91l2ZgZSabJchqTcTRevjzV3fbGPYgVKV4Xpu4dJ+qPkAiZb9EpHkdedipPp1wuhUXmQqJyma2JOaCMy55y2mYc/Q9FUXKrj6SLIr4Eljvm9RBfAvcq8VLlaDrSwUImlDtkFV02im/HEFEdF2OtRR2yBzIdZwPZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 22:25:10 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 22:25:09 +0000
Subject: Re: [PATCH v3 3/4] x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in
 struct mce_bank
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
 <YhUC1wW0mxC/Dmpv@zn.tnic> <66a6cc6e-55fa-45c4-1387-ff9d055eec23@amd.com>
 <YhVSecR7DqhNvFod@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <340dc083-683a-0f4b-0c58-62e86820a593@amd.com>
Date:   Wed, 23 Feb 2022 16:25:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YhVSecR7DqhNvFod@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec82fed-51ad-4199-521b-08d9f71b5a12
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1301A1A9E3DF2A4EF867CAF1903C9@CY4PR12MB1301.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JahDc5DbH1WXbUXNGUhYw8bx+5kA8C7n2S7XhBXRPN+xd2RIns2UMLs9SytDAcH/TTcI+nL/7t5lqB4Oh3an//KDSsqWzzB8r0iGAB6im+GbsEJ+EK5IWPJIpiLzk7Lw2cLZDQWXDNXVnoQyWA6FQJkeRFejVCuerBxcufjFInwU6EhbJKmDj9dgB/MWxBpIXM8hfOOHiQRoExtMUlowmSYgGpLfLDrATgMfQxpW36GGH+silDoqofb7RkiFgkMhw7i8XY2V9Y2gs0fUjpzal9wa5CMHPskvArRYqNQMvk/iS7ck5Rey78ilKLwIs2EbNZ21F+4EjX04Epj5tP2CTEmF1lVDQHU+s5yx4FB5ukQNlwtHWhuXaZ0FVSbbVEYkh5XTW+Ljpv7fH4ZsHWruhHlhTPQ4OF9DX85qLV0GNxWt8u0c2a51yjIPCLVO8zsJC2FXXjdsdqUDnyAUgYUygeS5Ch5ARkSwWX/R4n90rRN4VhHJZiAIg82+QUSscDW6LvgQ129YndYvzH2/bAYh5dO0yNFgOZowCEB+1csk/Z6mHjac9hz80Uz3AnJbR9FfsmAX1je8JJGMqNkJISOKgE43y1GBss76ZpzlxVVQQ3ElFPAPTupMdomLbWxgc20USfMAO5UHroWGzG4wDzPxW+xeUJVIOJCbBBT8PztdmmCok0bSyigyl4q/r6CKvFTJdymAM/5mdmOFmhJi7xITl/hlZZtHthJolUoJamySCFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(83380400001)(6916009)(316002)(8676002)(4326008)(6506007)(5660300002)(66476007)(36756003)(6512007)(186003)(2616005)(508600001)(6486002)(38100700002)(8936002)(66946007)(53546011)(66556008)(31696002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmo4S2dRV1IyTnlLQUlTNWJjcTJucnhja2gyVEdmcDNVQmJGb3pMblBLUkpO?=
 =?utf-8?B?RDh2SDVDOWllWXZ4aFlJUGVSc3ZieWs1c3RxVWsxUFlHMGdzbHcvaCtBaXJv?=
 =?utf-8?B?VXd2bzZwajNqYU50SUFzYllmOXhpVWxsUE5aR2VSdWxzSmQvQi9ENUdOajhs?=
 =?utf-8?B?bXh0N3BzWjhmK2w0QU1WV0twdm1kcnNFNmR1dUJaY2t3MG5FczVuTkwvMGRn?=
 =?utf-8?B?QS81dXBEdTBrdU10a2Y3NlVGVmJSVHg1ZFdJcnlnMEI1aGc4UkNwK1ZjK1VQ?=
 =?utf-8?B?LzQ5bXloRkc4ZkozSTlDV0grM1lNWlVKTG9ONVlOUUpEM25oRFd4OWJZZCtx?=
 =?utf-8?B?QVQ1SFZZV09MK29UM3QwM0ZubjlPOVdNeVZGYTBWRkJtNm5VSGpRcEVJNVht?=
 =?utf-8?B?WmlWbWQ2L1lkN2xRdllvUWRJSXp3a0ZPUEh0QkYxWlhBb2ZJTzl1UUJiQWtI?=
 =?utf-8?B?bmpJWkt3TUJIVGNLY1RIdG5Tdm8za0IySXZ0SzdYbkFqR1pmK0RVeGhMUkdV?=
 =?utf-8?B?VHBvZ3VIZ211dVBPSmU0Y0xreWpXNTlXNDlzd0QrZG1lV2pDdnBoMnBLOXpt?=
 =?utf-8?B?azdyOGJmekJLbFhNYlpUSGxsYTZzMFZ0VmlhSEhlMDZLNHNDdFc4elMwcVNH?=
 =?utf-8?B?TVFwWHBKY1k4eXh3ZEZrVzBDSEw0ejVYd3N1MlA3RzJya3pwWkFyMW0yV0Nl?=
 =?utf-8?B?TEV2eUN4aW5LYzU2ZFJwV01mMTFzWVVPUVBJcjhidkZWYWtrY01FN3hBLzZq?=
 =?utf-8?B?VFhIR1RMNkFuTm5jUTRCUWIyRm40SFpvbnR6L2htY1lrSVpoY1Z6M28wZkcw?=
 =?utf-8?B?c0t1NFZOTzY5Mi95azdjd3d4V3pUNFRYaGVmWWFIQ3k4ZVJGOU9NQjhkZzhy?=
 =?utf-8?B?UmpWY2VVdlZXbGNrby9xYWRLKzIySlVaL1h2ZDM3UzgxaGNIWThxbjFOOEFi?=
 =?utf-8?B?dFdIc2VvUXZIWmdkVFdkczBhVkFLVld6cWhHcGxodkt2K0JHZ0VCOUt5M3hq?=
 =?utf-8?B?MXZHSHpsZHNtY3VDaXBnK3V3bXA5d2pVcW9zWUE5cXZSSXdQbGthdkVmSUg3?=
 =?utf-8?B?dnNXVU9pZ2JpajZ4SXpHSEVkRis1TDlkVm90N3djSnpxVTI0MnI1S2xndkJw?=
 =?utf-8?B?YVlyQis4WnBNb2h1dDJGcTIrbGU1aDgxckwrZGlab0RYb0F5a0Z5SFA0UE5R?=
 =?utf-8?B?MHN1amVwSnNRdHM1M1FPZkxCOUdYc0QxUmxrREY1ZlRRTEIxV1VjQTVQQ2xG?=
 =?utf-8?B?UEwvbEUwdGprN1ptejF3UjY1VTU4blF4dGxUdjVUNEdlUFdoOVZscHpXeVE3?=
 =?utf-8?B?WWJhVFBicnJkTUJkRTB3M3phRmN2VnpFOXA4V3h1aEFMV0RzNVdWbzdsUXFH?=
 =?utf-8?B?amsrQ1VKR0IxQVhZZnVVOU9EL1kyMG9KOStMZm9OaTJGcURIV2t1N3ZmSnlS?=
 =?utf-8?B?SzExNENnQkNmMko2Z0xDWjREOFhSbmdYZExhbDNoZWFEdzB5K1k0aWJiekRJ?=
 =?utf-8?B?aTVPaTRVRWwwVUNtN0x2UzBWQzdCZUhDTGNBdDlzby9ZS0ozd3dxbklQYjNv?=
 =?utf-8?B?STBTa1gvOWZPZkx3Y2dwNWlPRXBKeFhFYjh6VXJJdWJ4eGRSbzJLYjNPeEJK?=
 =?utf-8?B?Q2dhaTZqd2tmRWhIS0ZZeFhuYVNlNmtQN1V0blhoWUl2aHcrbXVIRVlQdTM5?=
 =?utf-8?B?dSs5T3A5U1pYRTA5bG5FVFlLUlV0aE5GQW92NEdIcUJOZmMyRE80dTFtb0po?=
 =?utf-8?B?VFp5SmhCSWNRdUJCT1BlSWEyYklpSHdyUjNqYUw3Z3dDTTkzcVltdGl6d1Jq?=
 =?utf-8?B?RjQzTVVERG5oYTNMRGsvV2pEOHZHenE2R0hQRERnL0JyY2xUR0R4ZmJPekVR?=
 =?utf-8?B?d3ZxbDQ1L3JZTmtEaWhDM0xSVlpaTWVGc3FaaU5zdnhiRWVCNEw5MitLZ1VD?=
 =?utf-8?B?NlhndS9MaEE1dEFOOUVJcTVuWnh5Uzl4Y3UwSXRVM3cydE1UaVN6NmxpMXUw?=
 =?utf-8?B?SGErZEdaL3pLVENPR0hncHJ5UENMZS9CZEpkMTIrRXBDOGsrU243WTF1S2Jv?=
 =?utf-8?B?eFdxWmFicjNCY2luZ1BtY2xqQmE1NXlxU003Uk1tR25Lc1JhSG5Fdjg0OWpy?=
 =?utf-8?B?SzUzdCtiTGIyRVpJVEJjcFJKQ1JVTjljTHY3bm82REFuMXphZU9FQzlINkt3?=
 =?utf-8?B?cDZDWnBFcldhcW1WL0hmdzdHcGRKUmFKRmRWRXhkQmxPamZ1QStHc2ZXbndS?=
 =?utf-8?Q?G4biKD610aReaaL2a6LNLMmF4V8uIlXaC7dP/ikG38=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec82fed-51ad-4199-521b-08d9f71b5a12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 22:25:09.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1/HOwApKH0PjYcnR9h2jMYg282Chy02dvj5fmgBOG1RqZkoIxvRziWycGIU25GFnIaBRJS52XW58lzvRxZDdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/22/22 3:15 PM, Borislav Petkov wrote:
> On Tue, Feb 22, 2022 at 02:47:44PM -0600, Koralahalli Channabasappa, Smita wrote:
>> But what do you think of severity? Will this make an impact when handling
>> panic severity levels? .. mce_severity_amd_smca().
> Well, look at the code: severity grading gets called when either polling
> or #MC handler gets to log an MCE. Reading an MSR costs a couple of
> hundred cycles. The whole MCE logging path costs maybe a couple of
> *orders* of magnitude more so that MSR read is in the noise when you
> have a 4GHz CPU executing 4 billion cycles per second.
>
> Now, that's for a single MCE.
>
> If it were more, say 10s, 100s, 1000s MCEs, then the MSR read is the
> least of your problems.
>
> But this is me conjecturing - I'm always interested in a real proof
> where it shows or it does not.
>
> I guess what I'm trying to say is, yeah, sure, speed is mostly a good
> argument. But you always need to consider at what cost you'd get that
> speed. And if at all. There are other important things like keeping the
> code base maintainable, readable and able to accept modifications for
> new features.
>
> So there's always this question of balance that needs to be asked...
>
Okay, this makes sense to me now. Thanks for the explanation. I will
drop this patch in the next series.

Thanks,
Smita

