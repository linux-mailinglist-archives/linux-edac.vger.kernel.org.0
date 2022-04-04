Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9D4F1DB9
	for <lists+linux-edac@lfdr.de>; Mon,  4 Apr 2022 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiDDVlE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Apr 2022 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380674AbiDDU5X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Apr 2022 16:57:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752630F6D;
        Mon,  4 Apr 2022 13:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyiHtIN51ZIr6u3JJIH4UopzES/YZegUXVhFWEceZ5pABcsguhIJxdZ/LwXGD05go4uilHVHAqzhdfzBi1pp4xLAbg3GVw8DxKD2QWnkMTDU516LQOS90Epqha8O/r+/9rivfgnzqL2hFilCN1KkT3f3LG/L0MHOywSHL0SBLgeNbkNrBFXygKwsEootmFU9HltntuiszeXmmGMvKP9TnVf5FX7qCYQuGT01Ad0lacIqTdnNKE01i8GcIRW95Pi4KWICfOpxluQOqfOfzKVolGVKHNOD3o+20a45YifW9aiezC/YAwXdmL218+Y2yNO+xrFaMZ1qo0b1X/b1Oo0bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE4Kx8Zxm1pfKjTwd69TUsC+c+JPyNXIkKaoVu7RgOE=;
 b=V+xCtqCrqaA+3o3l4FtdBLDEd0fegNPUiwzwrh0LW51z0dz9qxIdB5XH4VrL3Y5a6hed8A7orPxft1+2dByjI1m0wFfWlAXwI808DjrG3kbOkHdj6X6pk/zBFStXWPAR8XjVHU9zaAmXsw5EIci6kcv/JfzBC0ti76C7m8fYmhrcfpE49LyBNbmYnNzS+w/i3St3ERFLzsHnS53dStCwV8Hx/LDbEPpcMMUkFLhJBnnU8TT6qelp8roD/Z6XoIUvTmMaVxHMfq1kYChvy0CCnbgOqXm1QS7CN48Zbf0TSFTdoS6V4UeOAUx4enkQXbMxZz2vL34mIYymcScYQcQ4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE4Kx8Zxm1pfKjTwd69TUsC+c+JPyNXIkKaoVu7RgOE=;
 b=G/4CpGK4FGP7feNIRrR4SCijnrB+L3sPnZ5sa9g242MwmVbSRJWYBiK7Slcp2T/YYIHnBZT7zaMqOViZXDqI2nOTuur0sd2GAbZmpXAHqR5D+XyoyQ2E189u5KuAfQZ3MzspO0fyEYQwFbZo2Q0TVani2So32u7Eu2pYi4g+o9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:55:23 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::482f:9ad2:91d9:ddf4%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 20:55:23 +0000
Message-ID: <54599d6c-204e-d7f6-21b6-15df7acad53d@amd.com>
Date:   Mon, 4 Apr 2022 13:55:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr from
 MCA_ADDR
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic> <YkmeJFXXbu3aLzzw@zn.tnic>
 <Yknsbp+zMh8Uev8+@zn.tnic> <87mth2kkhc.ffs@tglx> <YkoHKTuGaFfsF6qb@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <YkoHKTuGaFfsF6qb@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 940635a2-e618-499e-8998-08da167d7036
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4283F74C149A82A2305EA9C290E59@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9h9ELtjAkMmvrvIdO1QWPznPb6xVFq1+LMmHIbrTqmQT5+lm+unN0iPif40MPDErpERKBUjYABpMG20+R/uXVvb5G+089xRmS3ddON6tTNnJIPEybmsyMdZWEkyDh14T8toXi849P8BIOc0JAeMh/Vp6Y0zVlrD+3ZqFT2V1tLggA5LSF8FEeI/o4shS1K4lsiDZgyU6BECCLObG7UMGSburEl0xqnaUPBrJgNYythRbLJMULz95YieIF3FXAO6Sv+y0bmhOabhHWoYLHd4Rbx2xXRx3c/JepQY/s1OmG0aNEzWEHkuY3e3rlJqHRS/cIGunD3jSwPMsC2J+2Bo7AbsWXD30one+2QSdHaKZmNBFj8Z966kLPbMg5U+79+YCvVWvArqTHVnHsiGKGJUAIfK58LhQkwATzi6RHH2ZzD1gHwDsNkt5j/FkJsevGQP3HFwo/44dTylTzlpTS9hvUSkGKQXc4gpJLkM4DEPqF1zhDq4wZR8oVqvOX1Ua2C/sGtkzZIp6yTJEvc92nigjcVUQt/EArBjE7c/ryw5etiJbL8zOgejvG8PiGXV9/ppwLiLqpVX/sf7qnQhWwmABpl1Osd8EqdRv8PkZVW7R2wo6cJrpA+vp+jMCJpUbd21qXj6GKuVdAZVCMs88ro922mf1zK8kAFQ/XayFhAtjkTgPiCfFfNgbscSO5x/oBT73ohcX+zIlEIp2twiwnwLXe6LEArFLAttivt4L37ekKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(110136005)(66556008)(66476007)(66946007)(31686004)(36756003)(8676002)(4326008)(316002)(6512007)(53546011)(5660300002)(31696002)(54906003)(7416002)(2616005)(38100700002)(4744005)(6486002)(186003)(508600001)(26005)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVsVjQ5eVRzRWtrT1p3TklOUDducUhBWnlqdklqc2F3NGlxODZBTVZhR3Vn?=
 =?utf-8?B?bWJOMXhUVVR3eCtMOEZ0M0Z6dWVuTWJpN1hmOUx0dHVhRzBZWnNXZTVxTVQv?=
 =?utf-8?B?MkF3bFp1SkRQVXRKZlpCaDhrblNkdWwrZzlYbit3ZEJ5a2JDTUwzcUhtbjUr?=
 =?utf-8?B?TE1jL1JuYXd0OENVZlN6czZwaS9xcVR0OWlRSWpKUWtHQTVpYVZET082dXRF?=
 =?utf-8?B?RDllbVRqTTdWSkk4ZkZjOVJjbmpnaVZ6NWsvQ1dtRnBTclJ4WUdSUTJhYmJm?=
 =?utf-8?B?bXVveXJ4aGplVndaU1kvS1dwV2JTU2hVeTQ0YTk2MTE0d0JrbU0rR0s1Y3Nh?=
 =?utf-8?B?K3pvQUVYUFZYRDkyellVV0M2b1ZVK2RjbG94a1NVclZwZWdNWlN0QUwwSCtV?=
 =?utf-8?B?OE1lOE4vejQrMHh3NlBMUWNZYnNmZXZiN3dpT0FiMGFuTmlFNHY0VkQ0Z2JE?=
 =?utf-8?B?SE1tdk1FYnJWQ1VuU09talNKMGdGeHR6NXh1ZERHdW9lQUQ1S3Z4TlR5ekdD?=
 =?utf-8?B?M2tUMGY2amxRUk13SXNWZ1hSTDhnOVdHMDc5VHhCKytpZGdWUFIyazUyWFZH?=
 =?utf-8?B?NDF6b0tLa1dieVg5djJaTWh4WkMrVHI0NnA2cVJJMjdPbTJzSDhuczZScFZ6?=
 =?utf-8?B?bXBFUTBQbW9sMHRQNWNKVyt3SGtrTSt1cVRIUVVib0g1ZUxPRDUwTXR1WjFx?=
 =?utf-8?B?R1VibmpvSnV1TFA4UVJOSGJpM1NmVWV5ajNkNmNaTmxnNHpKSzRhLzFHNW5F?=
 =?utf-8?B?NWt6NGxnMTcwcy84VjgvUWFxV0hULzRIZUZGK005OVg4cFdDd3k4MVI4MlFm?=
 =?utf-8?B?bzlrSFU2MmZNcnVkNVNCWm1lN05kd2p3VXNWcE5tWHNuVElmczgzczRGb0pq?=
 =?utf-8?B?Zmxkd1ltK1NlK2UwZVluVXl4U2sxREdMRUUxeE03SVNWM1NkcVgzVy9YbzlP?=
 =?utf-8?B?SEFhcWFsWml2OEVFTS8wTTA3ZHIzNW1FK0pnMUhKWWlTMDl1UHBHOHFaY1RU?=
 =?utf-8?B?dVNXQitFSXJhamVyaTlBc1Fya3FlMW0vNEtMUC9MTmN4SWI5YlBESEs2Vmdm?=
 =?utf-8?B?MkVqZ1JXTGZlU1J2cTJYeTlSbG9YTENaYjk5L0lwamo0WmM4ckNwRW5ObkNr?=
 =?utf-8?B?V1lqWnB0N0Y2ZXVMd2ZoTVMwWk5LcmkvU2ExUGpldVN6Z1B5bGFJa094MW9t?=
 =?utf-8?B?V2hRZmU4enlJTzdUbmJjaklPTC9YcDAvQnVzQXNMeG5veWozM0ZCRDMzbmFj?=
 =?utf-8?B?aUw2aFVDUnZsZEJUdE1SWm5IYVc3bERVVWtMZGNnTUZIQis2dHp1Yml4NVdH?=
 =?utf-8?B?NFora0pRYVRmemhNYWg5dTJiSm02UjRzWlIzanhmdi9hMmc0dkJ3VVRVelpo?=
 =?utf-8?B?alY5dmNQUFNRUU5uMHJVcG1QNHhLWWVUeXJ6ZGg3M3U5OVhsR3lFT0VxOUho?=
 =?utf-8?B?bCtvdFh2aEI1ZXM3elJqVTdCc2dvZUdRaG5WRmVMVkRUeXFvWHNybTYydm1L?=
 =?utf-8?B?SnF6NzRWanhvNHArOXJIMXpDR3QweGdHMU1NRXpXTDQ0SUJYNUtWQ0xZNEha?=
 =?utf-8?B?NU9hdW9hUk9ETklTazloNFdjSkZEbmZ6LzJEcjNBMDJ4U3B5RkdPRkxpS2Q5?=
 =?utf-8?B?Q3IzRFNpT3lCQU50Rm9QZWVwOFZMZ2ZKTFE5NUU2V2txaUVJbGJRNzNkQnBp?=
 =?utf-8?B?ZDkrZ1NLYzF5ZGw1WittUzdUVGhpVHZRT3dwaHBtNU5MVU1wdkZRQ1lia01C?=
 =?utf-8?B?cUJhb3Z1R0M5TGdBay9hNEx4anVwTmxCalMwWWJmd0g1bVZKTTJYT1kxemVh?=
 =?utf-8?B?cjdUS2FmOURUSWROS3ZsRGRNS3BJMHBzWlN0RWNRNlRJOUpsYzFpdDIxbWdt?=
 =?utf-8?B?Z2FVQWZvVkNMK1I0emoyVWdWV04xVzRyVWRRQy9sVzRFb3ptS2xacDBFa2U0?=
 =?utf-8?B?QnB2SFhXSjVDNUpyelNEQjV4VmpHdmtFZ1VPSjg4MURMSGh6WFdDOW5WWW1y?=
 =?utf-8?B?ZEIrTHNmaGNNZ1JxbEx2VGxUZnpMY204ZUpTb2RzUkovUVlmZjF5TGdXWXl5?=
 =?utf-8?B?dy92S2hWTkRuL0Npby9XZGd0QUJYYlgrTWxSL1ZMMGdNY256WEphRTZmTnF0?=
 =?utf-8?B?Y243aDV1bU5hWi9RQnI3WlJBY3EyL0x2SWRna0hKNHFOVEx2OGYvanhsdkVp?=
 =?utf-8?B?NkV4MFFib21yaGpWejI2Zko1dUlWSnBTcFRkbU9zazU3ZEdJYzV4QklHcVEr?=
 =?utf-8?B?amxtUThmVVNVQ0tZdzRvQUtJTjhlVk55eWExaFgyL2JLZkhNMXVLMlRPU09F?=
 =?utf-8?B?RnlLb0ROcS9xVTFPRnQ2K1FudU93YVZBaFJDcWYzU2tiUkRDdTgzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940635a2-e618-499e-8998-08da167d7036
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:55:23.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di7Grt9knniVjrsVsh4PXFnnuKo/81TyGlc5BRxxmtIsthFN/iiiZrfwg6dE63HiZZIFaQfncZ/Ej4Ui9EotCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 4/3/2022 1:44 PM, Borislav Petkov wrote:
> On Sun, Apr 03, 2022 at 09:58:07PM +0200, Thomas Gleixner wrote:
>> How is __always_inline supposed to work across compilation units w/o
>> LTO? The callsite is in core.c ...
> Hmm, right.
>
> So even with patch 3 adding more changes to that function I think it is
> still simple enough so that we can move it up into the mce/internal.h
> header so that the inlining can work.
Ok will incorporate all changes.

I didn't quite understand what needs to be moved to mce/internal.h. Was that
addressed to me?  The function call smca_extract_err_addr() is in mce/core.c
and the definition in mce.h
>
> Thx.
>
