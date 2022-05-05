Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51051C8A0
	for <lists+linux-edac@lfdr.de>; Thu,  5 May 2022 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384619AbiEETHb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 May 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiEETHZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 May 2022 15:07:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4624B848;
        Thu,  5 May 2022 12:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGYNxofcw3Zx8C/6nbhsbj3Xp+KBHGg7Mugwxope9dS7NiG35XQoUneQmEZwI7Jf123g/zYOzDvf8nJWvCsUUD19Asx6QawxLQFt+lSaNcPbdK0caKfQWNmbx0ow6q+3IzUdJDz2/VM4r3f1MV2Nw5tgVJf4MObzDjqPA0CP/KfxrlWzLf20adyZk3bXesQp/owPz/d5rZR3BCz2YBgwUDo90LplMJeuK2kDHFM++Jzn/asB09CeHpqs5dbiUInDkwmb5IYwDmoWaEZWF42ovgJmSkX9OmDHpgRITk+Hp0SSwntBmQn3gMGK47yGYqvktV/coLkEuehe2MlbaNX0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGPBcykiPLPirqHjHv8uX9ENA4sFwunJm68qHM5gtjA=;
 b=ZJvDgiJ61X5cXZS7VitLb5+PqdrJSfVFjPdorPMk5TtCK1f5sYn2td6Mqz4IeeMh96m6s7dnPFsB6MzvqawhMimyS6mVWyt5vlcVm8K26mHm62t3xkIPaFs0pjSiQ2YnzcpT30qw1f0LMZcO7hibWV2hipONSMewFfSJLsV4q3M+SZJ/BiE5NEbVYkAVy0Q/VbMwRMicuhWZY8KSvLbFu/zfVIKlC1DvpVOcteiDGcEd5ynF94M+8waXypXIiZh8wvn5wYFrtUXHSSfPUO8BTGhgOA25TwN+8olxBnyQ2pr5oiDUJHQpVzLr9YhwE5yRmHS1TfjlhPuIXdyN31mDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGPBcykiPLPirqHjHv8uX9ENA4sFwunJm68qHM5gtjA=;
 b=aSXx5fUDMTU9uBp8MsUdnOrnfzFq6BxtbMsfZ+MYJtK+gz8tL1KKgQIDA7Oy1xx16ieve1AAIUCyRycNECEvw3tA4f+0HC/CLBcMgg2raiPI8T4/GAqkUYp+yCtRzbONRDqJ+A5aDyGDyaj/oNIsp1654zRLWDhYObfFnUqNNJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 19:03:38 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::c4e5:68d5:f7a5:7680]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::c4e5:68d5:f7a5:7680%7]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 19:03:38 +0000
Message-ID: <f6d7de83-2054-89ab-98a8-b6ada3e6e166@amd.com>
Date:   Thu, 5 May 2022 12:03:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic> <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
 <Yl/PupT3bAfc4IBW@zn.tnic> <5512261e-085b-65fa-605b-38692769f89c@amd.com>
 <YmXQBbCz2T/Opv5+@zn.tnic> <3fd01af5-c665-6dbb-4ed4-dfc39109d63a@amd.com>
 <YnGbHcMkLCsauzXF@zn.tnic>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <YnGbHcMkLCsauzXF@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94684fb-fe4a-4bb4-9938-08da2ec9f638
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB50045317346930D59D0085E090C29@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O99DOxvZ/jEa9A6JDLbgXLM6p6GScx5jF8Yj9/DlJdcVe+4oG5U/ScmDK2eAD5VYCdUmCPrZ2w8yKp/XFBi1hZWbMvYo7MlFmoH9DfxZQxrzQWXdZ9e/LhKuj/WODbePTjwe4yWdvdjWJg+vdWafItvBmikp0e0qOaMFBK+35Hnx6b1FkujfEFDQe2fVPpybDwgFBm9JQ3DPhilcKag6Pc3lfjTEk7sK4Q2avVwmqOVkvP717eELuCvK0DkTMd8bT5YIvguDLSE0zHHP9bgA8ojS47um8utwyx4ykI0eTFoG7mv52YJlVrNvsyvTw2iZ+Qo9yL3OG2nwFtfVtQxBmOl+jiJIRLO7q/ujTAFUYec4iqB9QXI2gdcX0BgvU9TRV0gA375k0tIh419YfG86izNc2rnvGStVwEbtA6fdah+6XfRrG3PX3GOrxNAZpHqWohHI9Dc7jjE+2RuuQHte3Z9QPLG2rB8iRGY6dt/7JizvTsdWc3JtbuK2JQ1wvhbyyTzvL2f0/im+KSdpp9pm4Mf38ymbTeJq3vd9iC97da3HIck0+Tj8WDe2CL9NdwXPZj6w4AHSvHf7rlB3EUGgt7y2MehXMWmjpG9hUT4E0Grydqmb6G83HvUoucu2VOsnm/LdwT1EfpFIjCox2dEc1dSKujSPv5WSCoDQkGo5D35beM6FsL6ZO6AKoq+mnKj8IPNlBj1sDGH3eMBPJXOPAD9oAS3MgovwafkBO8XQaKi3O+bl03a7Nm9RIfOs/mLz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(6486002)(5660300002)(8936002)(186003)(6506007)(54906003)(31686004)(6916009)(508600001)(53546011)(6512007)(86362001)(38100700002)(2616005)(31696002)(83380400001)(4326008)(36756003)(8676002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2x0aWdzc1hoWXo0NXAxdjQ5Mmc0YkFINmcxU3plYjVQcVI3Z0dUUE5jQlpG?=
 =?utf-8?B?bDc2clFINURydmFBQmYxZVo1Sk4xbkNuajVSTGdtSUR1UkhuMlk1by9LVE5S?=
 =?utf-8?B?SjNIcSs1NG1Sdm5WbWg0R0ltL1ZpUWZFNi9vazAxRnN0cDcvYThLKzV0REJT?=
 =?utf-8?B?d2tzeUh4a3RvRENuYlQ0QTZ2UmI3TzdhbldqMnp6amQ3OFV0KzIrV053T0VV?=
 =?utf-8?B?bWJ1eXhqdVJUdkMvbW1TKzVvRmFWVEVhNkxiM0JlTzFLc2hOVldMT2Y5TnBW?=
 =?utf-8?B?T1pGQzduMnQzQi9YaWZIR1N2MXdndUZhRjVjOExvWTdsTzlpWTZmc1dCWlJY?=
 =?utf-8?B?TG5iZ2Rhc25tbWJNNWIzQnNaOFRjNGl1U0hxbkgwaWtUeFBmRUFyMml3K1Fs?=
 =?utf-8?B?dWNvbldIcUVKQUpQQmFqeGw1WDdxdU90NXBMY3NnUUJvaHdPNytoUWloNmNn?=
 =?utf-8?B?bndrNW5DYXc0WE16N2h6bk4wMDRmbFZxTmNqdkJwQ2w4Y0VySXFHNkl3bjRq?=
 =?utf-8?B?eWl0eTF1OTdJTG1lTlN4RFFXTzR1a2oyeHdURkdxRUpBc2MrM2JSZFl0Yjhr?=
 =?utf-8?B?OGV0Y2pMM1h4K2UyNmwxbzdUL0lFTzU2ZjJOdi9UOTM2SjhOVy95ZVprS0lG?=
 =?utf-8?B?Y2o4a2pWNkFab0hJVldXcnBrUjNHT3Z2NXc0R0lUSVpxelhhZUR0TnA3TlN3?=
 =?utf-8?B?VnFmZkQrN2JJcUxBdmJXaVRQeVMyRlJWUmpOR0hYS0xKUHhndmROcHp1dGtY?=
 =?utf-8?B?RElCSmNwM09YbUU3d1ZhcTMwcEZhaVBiQVcra3p5VUFOejVRb3ZTZkVHdytr?=
 =?utf-8?B?N1FjUnM1TG12bmsyM2wwY29XVit6OGsxcDFBd1VRYUp3WUd5YlJieGdPWHc0?=
 =?utf-8?B?QUc5dk0waHZ6R21PMTBNUTgvRGFITEJkcUpsbVlTbzY2UmIzalp3MmxIc2dr?=
 =?utf-8?B?YWR4cFZXVENOVkdaN09qbWFsT3B6UXluQm1EU3lTWFI0VSthdGdLaHNxMjVY?=
 =?utf-8?B?bUN2WDRYN2JWcUE3ZWp1UnEvL0svNUl0RmtJSmNSVzA4RnlEM3dQTTB2bC9H?=
 =?utf-8?B?aFlJQWdtN3VPSmIvMVIxK1pYZVpQVjdHd2dxY0FuMklqNGsrV1IxQXJBck9V?=
 =?utf-8?B?TGtzamk1ZTR0Z3RYY3NDeUV4MFoyNDVjYTBFNmhVV0psVXRTamw0RTBVZlNR?=
 =?utf-8?B?MUhyUE1xZGEzU3JrKzVtamVTM0x4cFhRR0VBSml1Vkdjc1N1SFdqWG92dTV2?=
 =?utf-8?B?VW9WTURGTlBpRUlFU0NjR0JKR3p0dzlNK3FDMVNmT2ZsVWZwdHQxOUEreGNV?=
 =?utf-8?B?Slp3aHQ0bEFEMUYxVFdOUkZxdW5wQUpvc2s4YnVyaGhQS0lZbUlMOGJKaDdy?=
 =?utf-8?B?RWJyT3M2ZEM1eE9TNkFZSld5ZTh2T21HWmQ2SkJiSG1UR2hzLzJEcjFIN1hs?=
 =?utf-8?B?akFmT09WM3JEUXI5RWp2bWJBY1I0dzhXM01ubmNrYzlubjJJVmRkeXcyOTI1?=
 =?utf-8?B?Z1BQWkFEOU1OeENYVzU3TTV4ZnJTblJhODBhUkZXSml3RDZUcklRejhRWWl2?=
 =?utf-8?B?dDhEL0h4dDFEUnB2U2t3MUliOXpiRmJyUkMwQVFlakxDUGIvdFVDNG1HVzgx?=
 =?utf-8?B?ekh5LzI1eHFxb0krMThwZzROblVBUXVPcFllVjd1K0l6QkZDSEMrQ2cyMTZj?=
 =?utf-8?B?M0FmVm1nNHFOUE5HbFZFMis2dlcvbEk4amFpVFpHTE1pSldhbmZFdVRVQ3FK?=
 =?utf-8?B?a1RmTm1jSW1sUnpGRzV5d05LZ2dGaW54MlNkbk5jQi9sNmNMMWtRVUF3SDZs?=
 =?utf-8?B?NXJETlpZRjZxKzJOcTRsM3I4bWt4M05zVEg5emRSRWlkTWp0cUVaOHduazhU?=
 =?utf-8?B?b1dDa3dqc3lHQUpwTU95RGlmM2VGSHI0WjFNTnFmZjZKSlk2bStTSW1vVm5z?=
 =?utf-8?B?UUM4UFdDeFZYcER5Z3pvME5NdEtWMDJ0TFhValZiWnEwWllZQ2VlSkZqT2N6?=
 =?utf-8?B?d2lrRERGQTdOVnJaV1gzbmJaeW5qL3NUaEtzSXpRZVBUQU1rNm9JeDVtS2JL?=
 =?utf-8?B?RFFRUzFRQWVqSTZHa1NxZzZud0xWeXVLUUh6NG83UmZSRzNhRktNbVhMdmIv?=
 =?utf-8?B?Y0NhWjYweTNnaDd0dW9nRkYxM0d2WndUNXlzNGRTQzIzRmoxaHVqY3pQK2g0?=
 =?utf-8?B?SW42UXJQQ2dMbmdRbzVpVWdCM0FxL3B5bzVjbldJTVJJZ0U3eUxIY1ZqbVVr?=
 =?utf-8?B?YllIZlVZREEreFRyL2h5RzRTYWNXb1ZNMVE2blVwdXp3RCsya1lidVcrdzFn?=
 =?utf-8?B?VUxMK2lZR0NHNno0MGFhOWtRcWowbHRYL0tQdEVCWFl1SitaWHVudk5uazFm?=
 =?utf-8?Q?H2SKHN25TfJZgC7rBMvT0PDqOv69r1PjWaqDFjALUUOoC?=
X-MS-Exchange-AntiSpam-MessageData-1: IHujF9yS47BrOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94684fb-fe4a-4bb4-9938-08da2ec9f638
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 19:03:38.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HArtXRyrdnZ90eW3iZ9cDXsNt9NKXvMc1R7+tbqUG2JuFWYmV5ASALND+DO0TOaVxBr0kIlF5g4EFxnK69Ma1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/3/2022 2:14 PM, Borislav Petkov wrote:
> On Mon, May 02, 2022 at 08:28:47PM -0700, Smita Koralahalli wrote:
>> I'm bit more inclined towards your previous approach of
>> hw_injection_possible
>> check in do_inject(). This seems better than doing it in flags_write().
> If you don't do it in flags_write() then the user would do
>
>     echo "hw" > flags
>
> the command will succeed and the user will think that hw injection is
> possible and then wonder why it fails later.
That's right!
>
> I even actually think that in the first run, when hw_injection_possible
> is not determined yet, you should try to poke at MCi_STATUS of some
> non-reserved bank - and we enumerate which those are at boot in
> __mcheck_cpu_check_banks(), so you can pick a random, non-RAZ bank, save
> its MCi_STATUS, try to write it and if it succeeds, restore it.
>
> This way you'll determine whether hw injection is possible, store it
> in the static hw_injection_possible and then query only that variable.
> I.e., you'll have to poke that MCi_STATUS only once on driver init.

Okay I agree too. I will work on this.

Thanks,
Smita
>   And
> this way it'll be the most optimal, methinks.
>
> Thx.
>

