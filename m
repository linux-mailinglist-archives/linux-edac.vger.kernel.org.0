Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A497F4C1E63
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 23:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiBWWWq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 17:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243592AbiBWWWq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 17:22:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E143AA43;
        Wed, 23 Feb 2022 14:22:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0ah1fo3FFTth46n81pC2isjEY5tVy6oL1qYPLiIWlFYdrzNTj4JjVFlTQZFw0G1pXv2GCbvpk84tG5MEnDoIaNN8UXv4aqyDqeC75i+WTNKW/KSjM3v9S01iX+pniXaTBHMsZz6bLgjoNj5j0uxE1T6T1Ql4xHLmCsgFPlzXX+nISoOm0a+IVpqCvvBGa3XSSH9vV8KkI0Al1OXMO7Dphbh10kLYh8Ur1CmE37N3L7QmZze7quhEc5YHbxrpXMZ42CrQNKePHKduy0CBPPyUQk0RfZCBTCCgLGRJOonfQxysHfB2HkbmDPxe7zPwivJf7QQzMW9Must3wyAoHjkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cIwy7XCx8Z1ggk7miGB1zaJ2NpdqJI8K3TrN870iIw=;
 b=Xxtsx81IO3qkmvu5mPwDa3oeuI0d0iQtBdSRy9iLWS5+SRRkHY9/zIGPH6H4lX8AdkiuVz9rfC+GLezNOOH0ZOHgVSQIfxNys6DJTgWkanplwALqeNvJXslY/Gao/scsdLMZSlYwCzzgAtrF+AMrJasP69PSXPSQJ0RPaS+UApUJ7f3Y+2iOcyxRFJ7nkRL/oQBIui7rVa3DzAWsu9UBj5J/5cif1wO6EXc7giXNx/hwXFBt7P6u+TNxqNeiU1Uief9GWsf6TJBohOOS2QMqOStlCTx1nXORJeDiNcHw0RNG6EswOLf8aEwoi4PyRDZFfSnOiosDT8E1N7tWfVHXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cIwy7XCx8Z1ggk7miGB1zaJ2NpdqJI8K3TrN870iIw=;
 b=q4p/vtqw5/RQHBHlMWn1ROffM5Ec/5/jQGyw3cOJtLuuydKLEG5fBytDfYfYMcXh+Q6z5KDD00qx7QoZ44F0zRPQ6dudK5InhcuGupv+29ktWQMIdbUKB1MazKfdjx1yNlAn7jLtEdu6NWai/W0+PZ0hWCb7stRkAi9HbwIxmqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 22:22:15 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::9df3:5cc7:c61e:ec6a%5]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 22:22:15 +0000
Subject: Re: [RFC PATCH 1/2] x86/mce: Handle AMD threshold interrupt storms
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com> <Yg992OrUbfmtRizs@zn.tnic>
From:   "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Message-ID: <3979d97f-464c-e1f4-d648-526b3121dd63@amd.com>
Date:   Wed, 23 Feb 2022 16:22:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
In-Reply-To: <Yg992OrUbfmtRizs@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR17CA0030.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::43) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a69a2e50-3fa5-426b-4ab3-08d9f71af1fe
X-MS-TrafficTypeDiagnostic: SA0PR12MB4480:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44804EB781DD9ECD1684B9FA903C9@SA0PR12MB4480.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIp3sH2bA3HMnUTp8wFxmYge1Prh2LUODTDB5FW1WcyA5y34GR1IFTIefdFacOiRlPsWlSbxd7gG6LIFVYICg04unesiI7nn1no98yz71TAaEIS7YsdniPZv3nxHcpAVSryAqG94ZgUXv4a+XPnCOksPfQO8dJbG04StWoi4hh+tpAIjf1XTqRnLU5/o5zJ4+DxvvvnOTTsyVlIuHHat/VZulDX6dhZSYNN065D9xjY/fyWKiTcJmI6N244obwOhZltu0sV+cKdxtMx9z/kCQSdwLZu/lQIIk4KoQVD9dqT8s8rEEfZOPbcN+9l+uaHJ03kiZVUayPrqhoTBRzZikATv/h/8Y1Oe+beLbyweZE6b29Ep4hb5XYScD03b5MDQZZM4AGGAp6iZxgd0UpuNDDT5OEwCWFVsLJsmjdZQa7kP3OnjcjblQKHiJBjKwG4PScJF0u/j8QiG5OnJfD/pa6u9acyfwcJiJ2su8jNKPuVIUgnpCQmNVlvW2qz9K0c6BZWwOPJpGbPJutkfbOL3qNYXWoJFaRusDYb8/zZim9U4E3OyoS4WxKNmyBtmGF/7GcGeZHxC4sl9u7F1u6c8d0ylbkMWRmlA3aztabMOD9yndfIsNJQxlLUgYtI5Ck4FMY9UwEoypP9EITSr+khhBSIgvxC0KtK3zJqs47zZCHBNwXCm83RHmbGzW99Z9+kLS4M520KvROddOAsDuP3ep+AcVgvqXfkvRdpJcUjwS/rULJgIJjT+rNLoz3ditjS8qYh9KizeA4x9OKDzHx6qlKEf12RcaTzIrvVNn+NjkG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(6506007)(36756003)(5660300002)(6512007)(38100700002)(53546011)(186003)(2616005)(4326008)(54906003)(8676002)(66946007)(2906002)(316002)(8936002)(6486002)(4744005)(66556008)(31686004)(66476007)(508600001)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZjYWpUQ200Y2NRbGYrZExKUC9NdU9laFZPdW8wSncrc2FXVWgwMU1oNmpo?=
 =?utf-8?B?eElLdFYrUXN1Y3M1bXROTHMwNmdzeFUvblNmend4NGhORHdRWFpsTkwvQ3dv?=
 =?utf-8?B?TWd4c3NETEU0QmhLZUw3RWRUdHgzRHNsQWhWRkxJSmxXdjdSRlZCZ28xUWo3?=
 =?utf-8?B?bUVxNjQrR2dJekRad0kvVFpwVSs1bkR4RG1YaDl0SGlDTVpWVDJ6NTdaODQ2?=
 =?utf-8?B?VlN1ci9BeGtUbytQbHJ2c2JZeENteUJvcUpmZjcwaXhlRmc1SGtPNkVoejl0?=
 =?utf-8?B?YUhHbGc2ekFnWWlSTzlQNTlqYmVnQ3lSOThmeVArWEtJT0pPTzBYMExiazJu?=
 =?utf-8?B?eVdxcDBtNWd3UnpTSm03ZzhhRVI4ekh3blVUZXB4OElyY0ZwbUxISXlON3NV?=
 =?utf-8?B?MEVEMmNFS2hGdFRQRGZiN3p0aG9aNmU5QVorNmRTcHYrMEpzNm5NaTM1cEp3?=
 =?utf-8?B?SWk2NGgyN2pFdTBra0xPRldhekpEV3EzekwvWjFtV3h4ajdpQXZNSzdEVDZt?=
 =?utf-8?B?UkJteHk5bjlyNVlRam14U3crM0ZZNnhDc1M0THNhSUtSeUcvdThXQnVZeEhP?=
 =?utf-8?B?ejYwZFhDdExxeUpna0Q4TFY1WktsSk1pU2t5UUpGa0VxT2IwQ05SUWdodERK?=
 =?utf-8?B?MEljVmZ1Wnh0ZU11a2s0ZDFQVENSZTh5Y29ISWVGaFN1N29zOTJhdmtlMTJH?=
 =?utf-8?B?VVlobFhqdEdPa1poWitqa3BBOFlpSm4vMW9pSi9uS0JxQmtJZXNrUDlBNzN4?=
 =?utf-8?B?MFJGVzVZNW11OVNWTW9lS0dsbWhUQU1lQmRoQjloUENSaHo5eENPVjBKeG84?=
 =?utf-8?B?NkxWWURGYUtOWTkvdE1iVmRRYVBtTGR1Rmx1blN4MU1WZUdwU1NkLzB4dHFN?=
 =?utf-8?B?TUFmOFBQeXN4ekNwTlVtVEV5YmgxV2t0UVkxcTNPU3VHZlJrUExRZ2RwdEN2?=
 =?utf-8?B?MzA2cHZSLzg2azNSWmJ1NFdxTWpxcWd4OWdYbTRVM0x6ZHNxN1ZybWpucFZh?=
 =?utf-8?B?OGY3UVM0SFpySWthc3lSR2NYdHhGVjBKL0srSTd5VE1qcHpOM3BlN3VCazdS?=
 =?utf-8?B?OVV3bXFNazd0VklNaklVN0crZDNNSFA0ZGtLcHMzbDhGQWtPblhCRVY4ZTNX?=
 =?utf-8?B?djRqRWdQNXNISWlCak9kRFFSaGd4MktlcE1kMHR5dVV4YmMvZDNVbHRocEJX?=
 =?utf-8?B?UlY3SmFLSHM3NkthT0dHQ2p6ZDgzQnF2WWZrRW1GejcvM2NBRTZlUExEUHhW?=
 =?utf-8?B?TGs4eW1IWlBEMmNyQlFKZ2h0YTJsc2FlMnhQU3BIaTg0Mkg4ZDdmWVZFT1Mx?=
 =?utf-8?B?SWRQZEJnbnUzZVJocjQ4dEtIcXg0T0pOR0FOeTFYcXh1TmZkaHVmVFdscmpT?=
 =?utf-8?B?bzhwcGM5RE1uY09DbVdjckpGaTRXaFhheTJqWXVMOVhBZ0xlbmE0TkpIVklr?=
 =?utf-8?B?dzlOSUZMbnpWQzBRYW1hZG5hZXk1b21GclRRdU0vNk9SeTlSSUR2dzFtK1NQ?=
 =?utf-8?B?NGs4WThqK1cxcGFyNjNxTXRiNGsrTXg5enpCLy8zb0ovVW92dHI1RkY1UGFx?=
 =?utf-8?B?ZE03NktRbXR6enFnRkJJQmFjQTQ3NXRnL2FpdTByb1pXQUdoNFM3VkRlL2xU?=
 =?utf-8?B?K0VCZjJHc0w5RHlVOS9UUXRBd09UT040WDZDenVYZnFqUGFna0tEUG4zcWIv?=
 =?utf-8?B?Z05vZnBoQVhvWlpMWnoxdFZoZTR6N3VEM2o2VllOalFoc29CRlJjRWJrNVR1?=
 =?utf-8?B?NTlmaTF1K3BQUWRPeUJZWTZ0bnV2UzRCSFVENWUvQ05lTTJ0aEt3eSs5dElY?=
 =?utf-8?B?MnVkK3FSbzlFV09uMjNWWkdsc2Z3ZEkvTUE0NERLTHJpTlVaUTcvRnY1YklL?=
 =?utf-8?B?aTlJRkJ1Z3ZJWlBvSkdieUJXWmxkMHBiY01sanNTMUJWTlVCaG8vS1kvTmRI?=
 =?utf-8?B?Tmt5eG8zRHpYTG9GYVNxMlRaQ2E1TXNqTlZUby9EWk9WUUVZc2c0a3VwVStt?=
 =?utf-8?B?Sm1jL2pyajJ0OW9Kc2Z4TXhrMVhWbW1JZTR2T2VqTnlUYUtHcUVJUHgxL0lt?=
 =?utf-8?B?eHJoN2JCRnJEQ0xuUk5jVEVaWURzbXFDNTBmZjlNMGJVZUhUR2Z4ZS83bVJn?=
 =?utf-8?B?OTAyU0hsVTd6dTBoSzZFTVIzTllWTlpWSW9Tb3NGZitVZ0hjTEVJOEJPbGFS?=
 =?utf-8?B?YjRyOHFQM1p1Q3YwazNEYTFFRVlWcHlQQW1FZHNsUzcwc0p4YXk4c0FUMElk?=
 =?utf-8?Q?Elv1IX60RFMMW7jGquvUU5OrfQuhAvyC0jBllw95B0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69a2e50-3fa5-426b-4ab3-08d9f71af1fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 22:22:15.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf9OzDietOMA0fexHIf8E7oM00A/YAgVFXyccJDvniR425pIf6Y+i+Ea1/+7U3Fgws2+4oqRrL74G4E0yin0GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2/18/22 5:07 AM, Borislav Petkov wrote:
> On Thu, Feb 17, 2022 at 09:28:09AM -0800, Luck, Tony wrote:
>> I've been sitting on some partially done patches to re-work
>> storm handling for Intel ... which rips out all the existing
>> storm bits and replaces with something all new. I'll post the
>> 2-part series as replies to this.
> Which begs the obvious question: how much of that code can be shared
> between the two?
>
It looks to me most of the code can be shared except in few places
where AMD and Intel use different registers to set error thresholds.
And the fact that AMD's threshold interrupts just handles corrected
errors unlike CMCI.

I'm thinking of coming up with a shared code between both by keeping
the Intel's new storm handling code as base and incorporating AMD
changes on them and send for review.

Let me know if thats okay?

Thanks,
Smita

