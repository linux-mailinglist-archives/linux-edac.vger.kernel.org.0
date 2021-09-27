Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B423E41A18D
	for <lists+linux-edac@lfdr.de>; Mon, 27 Sep 2021 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhI0V6B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Sep 2021 17:58:01 -0400
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:60073
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237237AbhI0V6B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Sep 2021 17:58:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUi5+BIEwG6VpsTWJ9GNHt8vOMdcvjHSrfjDzdBIk9aoS/QbHgy0grJuXH9pfDht0f3q1aiI4iYvzzHmQtW8xHd/DCROhRh5p3jpBelZuZ9la9AoFwe1z4D/FZRbBtJmR7D384ATYVw7VZi9pvCY5+DDwEuDrSc5BB4YyQBo31S2Nnq8wX0QfVXvmSgf+9l6CAjN4hKjTt5aW7HpvMB/WCc8NVlDyrQWRSowciemAA14aUDIZI+N64TsFfhsu+UkG2nlGaJU41z0VBOQ/7P7QNg+DRjesMlZjGtgeZSb5qJlWGM0Qhc3M6EYkxLoI+8hyMtY3le0cspoHA7JTK+DSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LmhhiXBlXILDVQmzr+6/FIEbsfd4lBnwWjjsgxwGsso=;
 b=CIxnsMUchgZ51eJ4l4Z1LR8Ke+ZoZCW/vUv/KsWxPEsFiAfswVCwlGxRzxriE2wSoxlrLZs6rED7I95Xc1ONUdylgeSRs7YH9EWOGpXy8KJ7sUc7CQJpd9VCjFXxxvDZKPg5t2MCRBKncaBH8DlA821DgaND2WxWGR2/zKso1DGtsAoLKBf9jJ+2c3mTGvGKyXy725r38T36osdIICh9TBweZhC4ugbqeRuZEwVHhBnLezkESv0rVKvF/+v6MeYR+BR5WJokH+0OPX32A7AWldQTMCfH4PQHCG/Tp1+AA6bZN8nIU0Clr0GYdXWsN4ezNnIP2M0wIvKsADeDFmtFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmhhiXBlXILDVQmzr+6/FIEbsfd4lBnwWjjsgxwGsso=;
 b=2k+Fv+bKZd/nsAO9cTpg7lFB09E03C4T5omqz5/dZHyjbDxfCKCpc1uFAhdnTD9IJBHN3CWwGm32zjPpeo5+rnQDAEd8yGj1QCIAULkEtD/Oj30M3PJyM7resRbKA4lBjFvhvzxcSbKuXvAI6D5wNHZN53vhOy3DCUxoWedNKMc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 21:56:19 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::fd4d:81ae:aa97:718b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::fd4d:81ae:aa97:718b%6]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 21:56:19 +0000
Subject: Re: [PATCH 1/5] x86/mce/inject: Check if a bank is unpopulated before
 error simulation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, yazen.ghannam@amd.com
References: <20210915232739.6367-1-Smita.KoralahalliChannabasappa@amd.com>
 <20210915232739.6367-2-Smita.KoralahalliChannabasappa@amd.com>
 <YU2Lm+11Pqg/RBK3@zn.tnic> <60d4f6be-76f7-e4b6-6fb5-2af78b01d32d@amd.com>
 <YVImVgsxyfQO7TGI@zn.tnic>
From:   Smita Koralahalli Channabasappa <skoralah@amd.com>
Message-ID: <7e790ba1-0b31-690c-7bd3-d8361109cef5@amd.com>
Date:   Mon, 27 Sep 2021 16:56:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <YVImVgsxyfQO7TGI@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
Received: from [IPv6:2601:647:5f00:2790:e32b:ae50:98a1:7c5a] (2601:647:5f00:2790:e32b:ae50:98a1:7c5a) by SJ0PR13CA0122.namprd13.prod.outlook.com (2603:10b6:a03:2c6::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Mon, 27 Sep 2021 21:56:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368438f9-8907-4c78-3af2-08d98201a329
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB299841345D2C59C7D6E3018E90A79@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaNmx4azmy167G+FtGH6zcbk3va3huDQFYTBA2UNuTbLjQtXU/fPy5s7Zv/zcMYRYSyGwvBLWAk/yLK6Rt0GpU81XDAFRZwcphEuWPUQjiCNEkaq7+8iCAYu9jjGBPm/PnQ6zCBZoQc6W2hPUX8DNFSkSlAGKv4hvTmwo9JHRmP29D4+0AMPv5XV1JmR1MZvRiUNBu2zHMdPH0oaZTAb/XzpSqCQrLelWv2u3VpmfaBWlL+2f9RGsFQl8AoG9nwgAnm7NmvJNgUiEyvqnHZS+hdPkEoAlXQ5ljJPM/C4QQmUQcMccbnhhBNEfgyRoDsOvhCh9xtwaZL7vCiKxkXN4KdfowxdWi3r7g2zdq7aP+GsALcOvPR4fcNmOYkB6n/zK39wcYjXv5yWLfLIkA95NcX5SnhFL6yHmDzpnnTUnOUpgbj5Zxj667wKSSZcXr3wS8IG7NHGSDO5m5tzN4yAOtT7H94Z6SqTub0s1vw5tt6/x/ErwHrsl/X1LW95OnEGwE3DJ9xHOw1LSmSu2F40XeYAq2SWK0Uo3oLdeddU5628kaXo3WLMNh5Th79L9vQOnEChNQhGwSFzjpot5yEVKDbrWFQugSWg40fgb2KDtdtkw0MFpotUMtI/dvRlwRbMFzk7/Us6fjMA5Iu6bfZE7MqxLB0zJ6HZWIghSa413csPWF12g5Ms+e/2l7rK9BKO+FpGM+KPKLlZagns0yBVOOlxkEPxPSo+ywz83q/k/OOav3usDNLCCH5uMibb+gA7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(2616005)(5660300002)(53546011)(186003)(15650500001)(52116002)(8676002)(31686004)(4744005)(6486002)(54906003)(38100700002)(4326008)(66946007)(2906002)(83380400001)(31696002)(36756003)(66556008)(66476007)(316002)(508600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdCSCtaVXE5TkY0VTEyWXQ2TG44SGxGSmhMVXZuS2dBQ1Q0SThmK1hJdWlz?=
 =?utf-8?B?cWxtNFcxV2lNdWVIN3k1S2w4VkQ4VVdydW1BdUlTNjhnVzZtSlZBUTFkQlZr?=
 =?utf-8?B?TXk4Z3F2OS9kUGQyTEMwK3FabDZ2WkRrdC9sV2dhWHpMZXpBajVuQWJDbHVU?=
 =?utf-8?B?V1hlbXo4ZWtNd3phcnVUVjdhQTdPeUhTZ3drTzg3NnpnR2lIZERUK2wvRFZX?=
 =?utf-8?B?R0ZHLzRjemErSitWQ0oxU2oxV0JudzBIZEtGVkJKYlFYNUpaMnNuTTN6RTdL?=
 =?utf-8?B?VURlTitjTnAzMThBSk1KVHhyek9tUjdldmJCNnp2dGEvb0sxeVNBQ044SkRO?=
 =?utf-8?B?NEx4UWZtbHQ0SFNvbnpSVkFjSVEzbXBKTXBIMHFtdVZ4RWJJMHdoRW1TcnVE?=
 =?utf-8?B?c0dlRVRxT3N2TjQ1T2gwOUk3dzY4cjRCQTdmYkIrMFhpMXQrRnRwNVhxSUg0?=
 =?utf-8?B?VDJjc1FkR3lwRlBCM3V1R2IyTHo1Z3U2bWFmaXVsbm5YOGNJREl2T3RFVTVR?=
 =?utf-8?B?TUNUaWVFV2hwd1kvcEFjbVVjQmNLY3I4YjY5d1RmbjBTN2xkWGwreStLdXg3?=
 =?utf-8?B?b25VL0I5VldsWU9MenZGaUlIOTExVzhmZFFjd0VxMG1LL20wUjZFSG5rSlIx?=
 =?utf-8?B?T2kxbG05WlZrdTVnYUdLS1R2WDM2alNmQ3RSWEF1Sjdaa1doTkRFcVhpb3R3?=
 =?utf-8?B?clMxdUV6NWo4elB0N1pmeXZhR3BQZy95TTRNdkRnYTI4OWl1WjV3MHhXOXph?=
 =?utf-8?B?Nm96eUNXZVNER1I3SmhwdHpzWUtwYnY4S3E5cHNZbUdGamdtQkc4M3ZOSk8w?=
 =?utf-8?B?M1NMRTBGNTUzR2hBSkNBOWJzZXBhdjY5S2oyNVJHSEpyM1dQcG96YzcyRXdD?=
 =?utf-8?B?dTB1U2pucDd3WVFzNVZDNXhmb0hSRjU1Q2l4TTdzM0JSVkx6S0F1ZStoVVJo?=
 =?utf-8?B?NTM5RHFzWEkyTzB3KzJNNFVGSys2bXZSSXZrdUtPeDI0TDEzSUFBTmJsSmg0?=
 =?utf-8?B?MU5WMkdmSlJuT1gvTGU0UjA3MXdkQyt2dUp3VVNiQ3BqbnFBU0FyUVJoZFg1?=
 =?utf-8?B?clE4RDZQWjlObDh3MG5nSjRNb25BVGt6dFN0eThBUzNnQkx0V0xWVndDQVQv?=
 =?utf-8?B?cVRsSkZoM095ZG1jY2paeFNDSW1zRGtHRWFhTGZ3SUxkY0Qva3pnSjlrQ3NU?=
 =?utf-8?B?b3lFOUJhdDJhTWR6TXhRcjlUSTVsd2p5TWZuU2h0MWlRL3RCbzRzNG1TK1Vn?=
 =?utf-8?B?bUxQM0h1WlA5dEZISjVjQUhVQm1teGlBTEtDbXhNRUc5UHgyUjFhV0RSaktj?=
 =?utf-8?B?aHJtSzRWalJCaWhCeVFFY0dqTjhyMWJJZjZnWTVMK0k0VWVMMHl1YkV4QjZl?=
 =?utf-8?B?NE96eS9KMlBoSTZ4VkJvQmltNFFvMUtvMm1LUWcrckpTc3U1b29CandDNFlO?=
 =?utf-8?B?blNKVENKWmFTdTlkTjRRL0tKZVFJenJFWjN5a1dTSk50dXpMM2UyU2JjcG95?=
 =?utf-8?B?RFFWM0t5cjM3aGFOQ0ZCRjdXbkRLMFdSQWZPUnZmVlZXUGFHbTZpdkI1SVcy?=
 =?utf-8?B?RkVwT0NUbUI4S29nK2J6YlB3TFB5WmIwT1duT0NWeW1iZHNyajlUSlVRNElM?=
 =?utf-8?B?TGRTOWZOc3ZZdjFEQ0JEdnk0WXl0Nm14L3FLU1MwR1pQcEdWLy8wMTl5V0RB?=
 =?utf-8?B?V016V0dsM21CODErRnRMUGlRdWlqa1hsNVQ3V05iMTNpSjZWdEZONlBCbXg1?=
 =?utf-8?B?MDVsVzE2eXFVVW1GSitXQ3NzMS9HWnZGTkMvckkraHdkay9xb0hoc2tmdDQw?=
 =?utf-8?B?Rm1RTXZZLzBzRlJUT3NNL3BLTW5WMXF4Y2wwWTFRVkJ3U3RZQzBQcTh2dHpQ?=
 =?utf-8?Q?kX3ZogzKguirK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368438f9-8907-4c78-3af2-08d98201a329
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 21:56:19.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKMEESr80muEkLjzj5spVNfQIuGLoPgXBLWxipjQZGIb8KTHTpn2zTaZ2J19eBTQfdDdOSz7h5wUUjjvEGXo+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 9/27/21 3:15 PM, Borislav Petkov wrote:

> On Mon, Sep 27, 2021 at 02:51:56PM -0500, Smita Koralahalli Channabasappa wrote:
>> Can you please elaborate on this? I'm not sure if I understood this
>> right. Should I read the ipid file to verify that the user has input
>> proper ipid? If ipid file reads zero then do rdmsrl_on_cpu?
> No, on a write to the ipid file you should do that checking and write if
> the bank is populated or fail the write otherwise. And you should put
> all that code in inj_bank_set() - that's why I say "on a write to the
> ipid file".
>
> And instead of boot_cpu_has() you should use cpu_feature_enabled().
>
> Makes sense?

Yes, this makes sense to me now. But you meant to say inj_ipid_set()
instead of inj_bank_set()..?

Something like this:

-MCE_INJECT_SET(ipid)

+static int inj_ipid_set(void *data, u64 val)
+{
+	struct mce *m = (struct mce*)data;

+	if cpu_feature_enabled(X86_FEATURE_SMCA)) {

+		rdmsrl_on_cpu(..
		..
		..
+	m->ipid = val;
+	..
+}

Thanks,

