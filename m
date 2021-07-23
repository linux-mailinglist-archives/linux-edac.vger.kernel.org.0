Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22AE3D4037
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbhGWRiC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jul 2021 13:38:02 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:50112
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhGWRiA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Jul 2021 13:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKs2BojEEvFmyvRgTbCI8+FFk1oDIMXF6niFIteQ/lERRSwxE5jO7LeM4wKVG7EuF3l2w6nryUh9y625HgFrSJ5M2sJqi+uYfne74f2wRU40z/YqTFg4siFCozY2x3Og9DDmY++qBX1fbZJIEb7u1v5A37cLuW21zXaPl3zUowX04QUnKSRE/q3AalFK+3EkRr0FSyTjDxFpEnyMYeMFnjV9EMJEpCeyCzM//SdRo+e21zOGy7oEw7xsBJ0MXRPbeQcZ+4szIFCbw2qOGqTOwK5gGVTjNwYYx7HGbRqJP6CsuliCuOfIar4SZ6wlO06aJzMksBweqT3Ff8fdpg4xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc3JQwFqIBMQQiu0iwgOsHaoWKLBpXdqJqpnOXpmeSg=;
 b=ThNqlD00MtZbOC77cnjrWskjKfh4f4HAgr7CkdnAgv2GK571j3Ldbmhaf/IVr2klbrzGAFfHZ3gIj0BHETKYSRVmGLqntCIiDmkfiRd4a+t5CMqbAUXmKegzi0FUvfsSnAZ4vWf/X70DKYs9oNxoHyWyB4reyptiyh3ROfjfYFiUTDoNakZBRmOm1gtiTkLYMNBjiSwuvVRDB694gcPwEG5H/Z3KvXa4DGruYJZr/DUnralryrDLT2tU8NTtIxm7i8fsxahJTspERMdeb1GUmS2bm/RpYKdx89SaEdHuNixDuVVfTm2esfYdDBS1eCfm6OAMM0yh73CFf1nDBcrPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc3JQwFqIBMQQiu0iwgOsHaoWKLBpXdqJqpnOXpmeSg=;
 b=qfmApQ2QToxnigxf9CzQO04cfMM4gSiCVKmRyLWBuDh4pYPIf6L8pzq+ZVFpvFFSpRlGG1+SmYySenk1eFol2qz7bq4hSIkgWW/+/rPsCiIChAkQJxjFU/DPJeZH44neCUpDs7Klr7MpUl8Dn2bTvr9so+BxMcCBwsDYhi8GYq8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR1201MB0036.namprd12.prod.outlook.com (2603:10b6:405:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 23 Jul
 2021 18:18:31 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d98:68b7:bb66:c697]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::6d98:68b7:bb66:c697%4]) with mapi id 15.20.4352.026; Fri, 23 Jul 2021
 18:18:31 +0000
Subject: Re: [PATCH] EDAC/mce_amd: Do not load edac_mce_amd module on guests
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, yazen.ghannam@amd.com
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <ce67dec8-f5c6-a91e-e0e7-4c819df87677@amd.com>
Date:   Fri, 23 Jul 2021 13:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.81] (165.204.77.1) by SN7PR04CA0208.namprd04.prod.outlook.com (2603:10b6:806:126::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 18:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad08636-be80-4052-a68a-08d94e0646b1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00367984562911AA9A32E28187E59@BN6PR1201MB0036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtqyrPYoVbFkWqCCIZLWwV6a15E1evWW4+OD+R970R/uihvbJvf2WGGiiG4It9o+K6vlMOIHKdgr3RqK7mG+cP4IfJJAKEwrbrpm3rSMyzQnbFqRoDLaa5tR+rp+kZg2+Wr79VWIgK4P8Er97pj1WQNoGrcpIFoYJ4SV1ki09Sx236yZdK8we3+vDjU7W+p5KVhJtASXX4yLnRxZHPOjLVZ2PhynyFx0I8OVqEftUh98ifTxQRhL+B+d1gBw2lz6syaeTAGXyKJN0P0fO9bq6UODrh7I/fL+M3hK8phT+odyQrTpl81rC0YfmTvVFZvs7KQu8ImVfIJfC6lvLpjkEdrmZz/J7L+h4e77GWDbGyuew/KcTJGdM2bzmeobq13lm4rsYxQ2/g1htJD25RsbzAYpDVhK8ELZns9cIxvrhvG3Fgcqy4BWVTWtaGAhvmGnUQTRrnkj6S82SMFWcmWsbpxF+np/1bdTCo8bqHA7eaLFtVnpRziwTR/CAr+N5VuPjjjtu+lkfCegmClMY4tkZePyJJflYtR8AyTqDwFkEEWD1xW5MonP/nx7hxYNcFg3kz+kKpCyTfn4+0FFETpi8QuaZy862Uv3zeAvbv7eZWnx1sSTvBtQ3SxYQAAFF1HrODLRpmjl8Q6MkJQWkN8oJFmPYt1rqJf5lyxdTVRstxq8OeFmGMsRzgaMnk2CKzC9CqNsdAv2G0vwlGEYbq9Sj+HhHQqLi0ZLGMCnLKQgxYJdaHmCfKvSJoH7APPl2PX4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(38100700002)(53546011)(2906002)(31686004)(83380400001)(186003)(26005)(5660300002)(8936002)(6486002)(4744005)(44832011)(2616005)(8676002)(956004)(478600001)(31696002)(36756003)(66946007)(66476007)(86362001)(16576012)(316002)(66556008)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5DTlEzYUNCQXB2YklERWpJcHVlYW9jQkEzTkYzbzBnemdzLzZBVTk5eGNM?=
 =?utf-8?B?QWxJL1plQ0loTUV3NTQwaFU2NGFxK2Z0a0xua0tQL25Gdy9SZHNCcFM5amlu?=
 =?utf-8?B?dHRtUVZ5MytpVlV1S3ZrQUhiUms3NURlZE1odDUxQ1ordThON1hSUE9yUFBv?=
 =?utf-8?B?bUxrZTdvc3ZNdHQxTjZPeEhNQ0h4RndsUVVRYi9CNVl0ektJZ05Vcmh3M3lJ?=
 =?utf-8?B?Q2lRUWx1WEVOVFQzVGhuT3QrVC9OcEZlc0xsTVlpUDBOWnV4UGdLZVY4aGpq?=
 =?utf-8?B?cERRaG9Ud1p1cEFoZDJNcTVLSDVUMWlpWTh0alJ0NU95UXJrdU5OcXBEQjJ4?=
 =?utf-8?B?c3FXMDhYTzZHcmpxNWpONnJHbnpDUERIK0VyRzgvUHRjVkhJVjJpZ3hqbnMz?=
 =?utf-8?B?VVBrN2hJcXR0K21ua1NEK0o1TWJJSElpSWZXK29XeWRrclVobkNacG1vdXlO?=
 =?utf-8?B?SFRuNS9QMytJQXFOOFRDbXp6dWc4SGs4bEVoZWtFaEdza0VFTlZRMTcxa253?=
 =?utf-8?B?OWtXMnBJeDBOUHJvdXloSHFqQVJxOHRVcGlnbHVIRjlNTUJ2cGZxVjFWNE9a?=
 =?utf-8?B?cEprcjF6L3I5NjhKMWJSbUpVL0JhL2p5ZnFkMXR2Rkw1eVVqSVJQbHFzWUlw?=
 =?utf-8?B?NnZQQ1cybnE0WlhMSEdMa3cwR1V2c3cwZXcvdVh6eENsUStXOHVsamVOelpR?=
 =?utf-8?B?RVhNcTlGS3VrTkhkY1hGVU1vWmVDQmxtTnVmUERpd0JoZERaM3lwK3dMb3pl?=
 =?utf-8?B?cVNrVFpUcy9KSDlia2VOb0plZDNxNHB0VCt1NmNENktleWd1UUYxTUlOT3pV?=
 =?utf-8?B?enFrWW1DaDNVVkJQbW1TVkY2dytFU044OG9VVnNiaC90b0EyT0gyMTBoU3Uz?=
 =?utf-8?B?bEZUMjhoSUJCRTdEdmJEVEpRejJCWFlkRVBTNW5saWQ5UlRFSFB1TmR0eWQr?=
 =?utf-8?B?Q0kwNHU2ZWFTem52d2tMbEFFeFVZZzcxRlFsaE9vODBORElLNllKcGhsbW1S?=
 =?utf-8?B?Y1BMSldqMTFhejNiQ1NqdklUVVE3eDdzblozRTJFTXgwTHQxNndXdXFFN0Zl?=
 =?utf-8?B?bmVxaVdSSXN1TmduaE0vajdqTzFIYWNIbTB0UEl1NXlCc01kWk9Va2JSUFVv?=
 =?utf-8?B?M2ZKdjBLWmxJaHRCM004MHJNQUs3Sy96TFJ6bDRlZitMckg2d1FzV2ZGSHlF?=
 =?utf-8?B?Q0pvVG1lTlpKK3ZlSlM4QWZCalcxbDhseVN2SmFhN1ZCWGM0a1h4S1k0RHRE?=
 =?utf-8?B?NGhBL25UTXF3MkN2WU4xaE9NSlNjVDUwbldobEFwUm5ETGRGYitaeHZpS2Nx?=
 =?utf-8?B?ekN4NWw1S3dneFRVelFoSkxNczRVcW9kTjA1aHllTFR6VUNUWFgvSUxqMm5y?=
 =?utf-8?B?NzdJcDJveUd3NWVxVk5kY25PUDI1aTlqdHFPUlI0dmcxYnpmam56aTFlY0gv?=
 =?utf-8?B?QnV2Z3BwR0xMRVhNK2EwME1KdUx6anlpN2RWQ0NFWWJiWTR6c1ZDT2lZZVd5?=
 =?utf-8?B?T2ZFTnhNYnRKRE9rbXM4TmFmZnp1MG4rWWlyS2ZwSzQyclFRU3UrRmQwYkZs?=
 =?utf-8?B?Wm9EdU5HV0xvOE5nZ0J3UC9ONHErZ0JVaWJIY29XK1E2Smd1blo1YjhaTkd1?=
 =?utf-8?B?OHQwcDVZS0YzMEc3b2ZVSGZlcnpIMWgrOEk4Q3UzOU5pMU5icU5jY2dJVXha?=
 =?utf-8?B?K0NlWHZSRkZ3WE9uMDJYU3lqSkdsMHZTZzdneXNpbUhjQzFOZnBqNi9DSURm?=
 =?utf-8?Q?kx6MfhVpWSVuAJFDSQJQ5rSVJUHvmZ1DrW4rMlc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad08636-be80-4052-a68a-08d94e0646b1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 18:18:31.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQDtHdF63cTwAcGyaI+gWxUmpui1JA1mxgPZopl+L6sNj3u5igCtg7rzQatXnxxsNxaziiH2bW1kvD837W9inw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0036
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/28/21 12:27 PM, Smita Koralahalli wrote:
> Hypervisors may not expose SMCA feature to the guest.
> 
> Check for X86_FEATURE_HYPERVISOR on entry in mce_amd_init() and return
> -ENODEV if set.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---

This gets rid of the "Huh? What family is it: 0x19?!" messages in my 
F19h hosted guest:


Tested-by: Kim Phillips <kim.phillips@amd.com>


Thanks,

Kim
