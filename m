Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D314D6AAB
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 00:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiCKWwj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 17:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCKWw3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 17:52:29 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71B29E59A;
        Fri, 11 Mar 2022 14:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLuvHGKG7I4qrU73P+HYeFflUmmpohPZaBglTUu3tTwluq2nvluKaTK8D4bjchI/UQflI70sK5YDPGbNzz4b7unNlcZL+6y5OAnVqm0N/JNI/NTuwMWG457VbIO/crjhm50ojzTxeSkWFdAg9klTnDr/ruhyhUc9+FP2T9PDQ1poOu0LVJliSP5odq0wf/avB6/3j7VdfIcj90/UuQnUTZqaKwQT2PQ6PF7LKsek7o/IbmxLTG26j2Q03Q/oN96R3OCAnPYViefuStvTtkM9tr3KZNAMN5I4eRYslWCZ9edOX4vbTMuifMODpOt885n4A/8+dt6z72Ahhp7hGmrZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF/hUGdV9kjnCy2Q1qQLAMf1s3PRnPt8RbF+heTXGgI=;
 b=XA2roOD3UqOC544g2lLpTOyyy1N/aGwO0VUr7FVe+rdmPkbGwAbMV2bxKcaoGTFVgtrTMroqrzgJJJKyo0c3uzG9flIePcmAL1zLyevobFF1MvieHYuMZZknqfOgr+xLET1w/j7RplsZxPLxuy/HyFBGZmWYrp40oYKqxB7TFmS4mdcSpXZ2wakKdgyRMerJ1cK+F6hoFJZiMHpibZ+xQB+4AXCvyZLF2DC7QOjMldLxn48m/tSSYHJ8mfP/AsHYoeTVKGy85B16vJR3OYVlEhkKkN0iC1gx/WgsMo/IGg0YHfK7Wz/WaIf6zAGHhxSZ0IvWCtDIr24AD9UVWbYQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF/hUGdV9kjnCy2Q1qQLAMf1s3PRnPt8RbF+heTXGgI=;
 b=Wympc9Ivg51qqyns4bfVj4OwI5+4czoHD/dPDHT69950qlGVgHxj8Ecl7eeRUQllQlU796zzcc5LUAZCXJDKFzoag7JSmDpcP9wm1JV4t21JXPC1mbQWKo5Vc1mtl31y5PxSvCYRggEoeNnvCYTTBEWqG+bIxNZct1/PTd7mR3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 21:00:45 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 21:00:45 +0000
Subject: Re: [PATCH v4 0/3] x86/mce: Support extended MCA_ADDR address on SMCA
 systems
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <b6bcde0a-8232-4384-4e48-156fee7a229e@amd.com>
Date:   Fri, 11 Mar 2022 15:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448d6613-c953-4598-9071-08da03a23597
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2875A87A2860D48D3688889A900C9@DM6PR12MB2875.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK2V7Ql+x+Q8pDXVrWNOfn/63kUA09M/CimQhdTRUwfj8U1lp13SCXU80Vh/+twPaEzl0aLgdp5rzJzVGCyVj8B6PohqP5+N4QpgTzFMBj/frE9hFvRlCsXz4bONMQrfel1QlwHpxow7SAsmISVbkEnOf0g/UGgJDEnodUbfL6Zwd+5Xz8NVZMMqsFyGImOGT1MQmK5IYRaXka3LHOahAxrngwPAVmYeXwc56rDKj8hePYjKTXq1OoRmdrz45QzkIbcW/dltFzZWM9k+rLOxMkWcjTubssWkliMAeDyUneoB/mu+PSSkPpr2OB5obbMNmiV/W2JUuqFxlteQR5VbI6It7prVB8KJQ5HmiFza5GQnKy5v+1G8iHay+XR/oCHn4SAh4DviAxskL5vO+qIX4TXdNKM66pOcdhXIvCRaexEZX2RN+wqKqRQFhUtsm9uSCPzz2kKSK3Zre1jGOgMkLJS3xQLhI6ziQpgpkI1xCf27Rs1xEawM7hWPtVV7gSEyUpzWK727PUNnOQi3yW4SC98qWZYZr3cIFQ/tY15ThRM+h/+BImwjEccE/LxO/Uxi/vBLcFFzMy1LiVunNFXxdyEH3IkHKjaZRnrXfgW2/BX33Bv94ixbEmuIcyKxNMYmWVVHwLkZWSL6BDySeeI5AG0gfrW6xabyZzSAxbXRzWcSmhJnQ3Yk8p03NrIbAVcLO8R3uJNjCjqizLMAuZ4cnl9ukyXZikf0/UPgBkE0C7h/yBg6n9P7kSEaj2OqMSNKUG4BcPnagsQWBrgzCCFxKCkky00z8pa1o/wteleMNBifwhnO2Aj+roPdpKs1M3JPailXDNttkEmOKWFQxG3bBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(31686004)(54906003)(4326008)(36756003)(31696002)(8676002)(2616005)(966005)(5660300002)(6506007)(53546011)(66946007)(83380400001)(6512007)(6486002)(38100700002)(508600001)(66556008)(8936002)(66476007)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3BvQ0FHaW5EN2RuTlVkOTIrdFpHeWwrS29EQWczeHlDVEhFd1o1ZDZ5NDZa?=
 =?utf-8?B?a0tvdWhFSHk3RDV5Zlp2aFJGcDlKUzgxMVZ1WTBLeWZyakR1bXFYaEIyN1NS?=
 =?utf-8?B?QW9NZWhmUktJYU1uU3RWK2NHZjA1bHg5c0JIK0Y3a3o2UTBsa1BxaDJBZGZZ?=
 =?utf-8?B?dnYzTDJFSENmYk9UdTIxWnZJSlFCTWVQVjBYcVllM0haM0hrbG9Cd2V4MlZz?=
 =?utf-8?B?SG9GYnpwSE1GUElaQU1IUGJxbDhJcmFseWhqRml4bHVidnZpNi9OQ3krd1Vq?=
 =?utf-8?B?ZjZadVFobDVjVTlkazJWOGtiNlk0SUpNbDdSTFpnRlpSUVBGY0RMUXU1Umk1?=
 =?utf-8?B?Q2FlR2NvSUQxU0FmWmlNc1JUQ3JMWERRbW9hU3RxTGhxZisrdndJQlNjRGsr?=
 =?utf-8?B?ZmF1YXp6dkxxdGhta0RLcVpiNFRlRkpyeGZmMTVHNmpnaTBjU2VaNFFkNEsx?=
 =?utf-8?B?QUllK1FTWDVTK1YvYUZaaVNUWEhNYUg5S2VVVW1mL1BKcGdSVWxKU0xzSnhB?=
 =?utf-8?B?WUFVZy9GMVFXTzgxQ0JHcWpUSWJpSkxhL2xaR2V6d2ZnajZFcFdRRmtMZEJw?=
 =?utf-8?B?aGNFcVIvMk9ISURXQTAvdTRIZ3lWMDV6VGRIM2JZRGRsRUR1RWlwZ0p2dTQy?=
 =?utf-8?B?dU9rMjgvSnRSa2tsVUhXaVlkaVhUQll3RE9Sb0lkc2wvVENHKzBmdjBBZCtN?=
 =?utf-8?B?K0Foam5rLzZrVWxTVklpRFZha0p5bE5RR2pvNjc5c3VoR05US0htaDZzaVFm?=
 =?utf-8?B?eTZ0VHlNRENkZVpjaDBKSjdseXhWNENQb0h3SFNNUkZrQjEyWkVMYyttUlZX?=
 =?utf-8?B?aHNheWZ4akhMQ0lrWWJMYzdFbTVCMWgrVjcvMlN2b3BneFNzcTI1dnVUaFpU?=
 =?utf-8?B?MkVQcE4vaG5haERxTkw5elV1OVYwVWlWWjNQdy9IQmo1bzV4RlhnUWVxYW95?=
 =?utf-8?B?YlU2ejR3SmxpQ3ErQ1ZsUjdXbUwwSGhRMHN2RVVZSFpvd21yK0tldU1ONU5x?=
 =?utf-8?B?Z2xEYTYvL1hnS3Z5S2RJNkx2akQ0TlpRV1lHNmFyYnFIZk1rVlFwNG14YlVj?=
 =?utf-8?B?eUt0VHdBWWVPWVdHbDVDYkpyNi81WTF6MUtCSlZpZER4N2V5MFE2aFhBZTdO?=
 =?utf-8?B?S1AzMTRVdnVIclVjZFluYmdGdDNSaHlOYS9KTUp4N3RaZHhTUHA2YTlSTTJw?=
 =?utf-8?B?dWtSOGFseCswaGNaak1NRk5CaU4wdXlpY0cvcWJHS2ZtYU9Eb2J2d0lVSyt3?=
 =?utf-8?B?MERjOXhXR25wWWpTcWVWallmek1XR1JSaWtwczZuclJKTkg3U1ZkaTJPUVBW?=
 =?utf-8?B?bkNEcGNtRTZnaDNMQmQ4YStvREc4ZGcwdG4wMjczK2tFSCtwbE9yOXNYcXlC?=
 =?utf-8?B?MzQwQldKRmpOSC9hc1JRcmhJVmErUEh1Tm40cmh5b2l0dGY1cEZ1SGZZVWpH?=
 =?utf-8?B?UGQ0MjYyYW0rZU4zSEg3N2UyOXY3YzNneUlxM3VWZ3J0MFY4Q3hlUDIwSFNj?=
 =?utf-8?B?R1N2YTI2Wmg4WXJ4dGRobjhSQkMvcXpQL2dWVGxzZ2NWeFlWemdLREZZU2RM?=
 =?utf-8?B?cmdjMzFzenN0S2Z3Q01zQmRaL0I3N0ltZW5yM2E3Vit2d1FIQkhrb2JHcGNH?=
 =?utf-8?B?TXdLdjB2TFBNZ2E5OWlBZjBJblJPOGsvbXhPcFdxUUJFdDl6b3VqMjF2MXF2?=
 =?utf-8?B?VDNIdmRSbmpFMmxBZmhCVTNZNUJJTXd0MVhoUUtKU3d3S3VaZktDU1E5ZkJm?=
 =?utf-8?B?WUs5dkZCaU8ycU02OEdEMnZja2Z6dlR5QVNuek1Uekp5alhJZWg5TU03L3F2?=
 =?utf-8?B?bzNvbGdCU2FtSmg5ZURlbTEvanI1UlFPbnB5Y2xqWWxsT2pFR3VSeENWOEpM?=
 =?utf-8?B?YmoyOTlXd2JteFJ1bFpUaXc5dklZeWxIcE1meFlsRVY2bEpVQXlYUWpyeXE3?=
 =?utf-8?B?alpqT1VKSzVSbVZEeWhNRnN2ZDEyYWJyZjVDQk5kd1p1OWtOT2dTSWNUbGdK?=
 =?utf-8?B?YUxzL0lsVW9KQlV5SzN0LzZUZ0gxeDM5bDgzbnZyQjlVNFVRcFltaW5URE9p?=
 =?utf-8?B?YkdoajV4VzYvd01CWllYS2ZhbkNOa3dicGpUcWY3R0hoSnFtZndIeWxRSmVN?=
 =?utf-8?B?a0JsOTQ0bjJNMVhiRGtEcHRYQW9OaXJLSGdRcTUwQkJiNFg2MnpQeXNCVzE2?=
 =?utf-8?B?bkhXN0RyZVpSdlMxdXhWV3hxNGlaUW9KbEF5b01jM3JUNG5EbnMvOEFLS0Nn?=
 =?utf-8?Q?plad6Rwh2nt7Z0VDg+jdXlFQXAHVlSaITxQHPuojvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d6613-c953-4598-9071-08da03a23597
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 21:00:44.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq1ZehWrJRDKbFbr7LcJM1Wq1fm40Ni1wOHla1R3Q6C26Wyx1NO3vdZQIQUTGAFGsJFnYud6k2k/qreJlrVzaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

Do you have any comments that needs to be addressed on these set of patches?

Thanks,
Smita

On 2/25/22 1:33 PM, Smita Koralahalli wrote:

> This series of patches adds support for extended physical address on newer
> AMD processors such as AMD 'Milan'.
>
> The first patch provides a fix to avoid unnecessary padding in mce_bank
> struct.
>
> The second patch defines a separate helper function to extract
> MCA_ADDR[ErrorAddr].
>
> Finally, the last patch adds support for extended ErrorAddr bits in
> MCA_ADDR.
>
> Link:
> https://lkml.kernel.org/r/20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com
>
> Smita Koralahalli (3):
>    x86/mce: Avoid unnecessary padding in struct mce_bank
>    x86/mce: Define function to extract ErrorAddr from MCA_ADDR
>    x86/mce: Add support for Extended Physical Address MCA changes
>
>   arch/x86/include/asm/mce.h         |  4 ++++
>   arch/x86/kernel/cpu/mce/amd.c      | 35 ++++++++++++++++++++++--------
>   arch/x86/kernel/cpu/mce/core.c     | 20 +++++------------
>   arch/x86/kernel/cpu/mce/internal.h | 16 ++++++++++++++
>   4 files changed, 52 insertions(+), 23 deletions(-)
>

