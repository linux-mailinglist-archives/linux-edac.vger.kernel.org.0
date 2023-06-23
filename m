Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D173BC64
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjFWQOH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFWQOG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 12:14:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8CF19AF;
        Fri, 23 Jun 2023 09:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKOSu19Yors43oKAlM5S+Kq6xHOiPPF6pmjNHpMScH16mKpSJaI6iTQO3yf7z7NkyopxAUeSzShi2l+YmHoEYkvTwQyqrffItAtrka9mzYLWirNIdpt4yf2ATzPgrpyigOSjsxU0mgw7DpskaHsupSxuGBe5OjDaSsP/5dDzZZUvhmPggCEvZq87U/+8Lsp4AQy715nKO38/JwDILyvslehAlQxbkVM619+6My59jsd/lYL0JwNTlI3vtXApCm3/wdgxXDKp/oJNVDX3SolR68AHu0LI9XTYQ0dqVkVb7vCbGRIoHdOUlNaBegUuBc5TFBIh3Z6PjZJYE3E/zz0BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+5Az2Ay6lnnR6Z4tHuf/2s7RNP64VI4vjYWeU/pOxA=;
 b=aYcIZfgE+UvcR95Q6RGkEKIIUv+ZhobbdhCETbkWkaVlyATh7NofYORtp3AoCE893nEk5CvJ5P84xGeWQWbE1WIDafEiEiP3BVzgzymsXHW6kwUmb5lx5bzeSYUaA97Tri7b2PyLxTp9wRS7m+NiTHMEYamSwMLeTAFLK0KSEEY7Qec31LpvBhxDvh1HP/pav8xQI0Rh3t9K9Pxt6LujDUfqxM7ePHOuUOhSdmI2mRjqWYnOHbNsmKEM/gLm4qd0oXj8fiAnMWaSY8WorrcBYJmPrwjOfbsK6QbpK89fU25jFeWXFp8WOjiYX7qOCvqjByzNOg3xBpVJ33+u0wseag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+5Az2Ay6lnnR6Z4tHuf/2s7RNP64VI4vjYWeU/pOxA=;
 b=MyPsuCxEuZzZ0GKIbDwmjiSuOLLr4LUG20XJwoTVKfOLiY4MZ+tnWH1I1YW9IDargzEFV9CB5Rp7hXsRwkg7RyN5kUoNnMwV1veMlRMEoaZiGxIpLu6D3dbYT50kfid+k3/qcsic2enK8LjGazDtfN89I1gmpKM9coJuooGEsa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 16:14:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1816:6426:34dd:426%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 16:14:02 +0000
Message-ID: <5f40b5f0-3e19-5cf3-5bd3-eafa4d036119@amd.com>
Date:   Fri, 23 Jun 2023 12:14:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Cc:     yazen.ghannam@amd.com,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
 <20230622131841.3153672-2-yazen.ghannam@amd.com>
 <SJ1PR11MB6083664BCFC8047A5FE8F6A9FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f03b6c61-1669-c03e-310c-cc1364cf30a8@amd.com>
 <SJ1PR11MB6083961DFCA3D90922824189FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <77d51e2f-cd1c-9c30-5bd5-42b1d583db53@amd.com>
 <SJ1PR11MB60831A6E82329E1C53257F3EFC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e6b1af5a-774a-c3ef-223e-4595b7ec532a@amd.com>
 <SJ1PR11MB6083662CBA9A2F40512034D0FC23A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230623160138.GBZJXB4hlFM/ahvROH@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230623160138.GBZJXB4hlFM/ahvROH@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:408:ed::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa6f91b-90b5-4de1-e291-08db7404dc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whsxfomDdZGFWdsPYZ8oUDr3jpgvIA7iHcJSya6ta1tS1PSqwe2R+kgaKPipSsVtXDGDV6k8AzPr9o+F99phnlVDL2e5qZrbvRfYHl5jFg8TOMUIAKnBkiFIXDr7xQOn0KF3N/4Hp3U8OFlvoJf535WCaq7qWEKzKDg5TWw4D9PkCcFqiQXvjzvW6bEIdn1G+Zd99nO6YY0aPLed8CeYGnYRlMwBvGx1LW6V74rhHWiQNlIONZkut30FuhamwwjMfo0WSujTxslww0d0GWELv6Us4T4Iq6srWrVnpTkp8YRWkI4SMCoPmckV4kAypR+0pXVqRCvl9xJotGmfIbmCsWOioQB4rnF+K2Bv11wJvque7tbW3VQhSwB8djeNzFYr6jQdH56e3U3DMTA1Fc0AAGOmFEH+yH12dr7BBj8JywRMSOypqh1gjVwwPtcsUpQDPv3jwoWh5xk41fzHg2sPmWtWXmVx5bej/HHnO+e6QfhKt1Cbi6an6tc2nR2ECmALhNjZY5t6ubdBH5YGuWFvZ3hxbXGa5BMRXf9D86cyk0ywKjdU/jgOTEd6pDLcseprIH1ua+xDlJAeMVS0OmVakuKCE6ftU1JMeZCzIV8tSvYe569JJzJJ2GCrcmEMTKVTaChbJEPGszzBIsGFbvjB3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(41300700001)(5660300002)(44832011)(8676002)(8936002)(4326008)(66476007)(66946007)(316002)(2906002)(4744005)(66556008)(2616005)(53546011)(186003)(6512007)(6506007)(83380400001)(26005)(36756003)(31686004)(31696002)(86362001)(38100700002)(6486002)(110136005)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitBTWFaYklkZ3pZc3kzOHpRSHlZN1NUNUhUVlpaQ0Q5Z2ZaQklmS2NXZExJ?=
 =?utf-8?B?QWd2RlNCNnJGRnBYRlJyR04yT1U4bDZESzFCekVxaXJENUVhUkNRbmMxYlFM?=
 =?utf-8?B?ODBWZElZRzQ5azFXSzdHYXVhYWg4R0tEeHFvSDJMV1NhSTFyRDBxQ01sTGZm?=
 =?utf-8?B?MFJzWlhTL0lZNnNXNEtlQVlLWDhPMm1zUVdIQmRhZFlJeTlWeFhucjNxTEwr?=
 =?utf-8?B?aUlDMVIwL0c0bkJqSWV1ZXVvWEZWTjFpZTRhSDRwOWdCRWdrUFJvSVByditD?=
 =?utf-8?B?QkVhMEU2eDRxNnVaVzFOVWg4SmRUS1p4bWx3MlVwSWVrQXUwQ2QrRitVU0hH?=
 =?utf-8?B?ZFZFK0g4TDIxSlJ1UUJyMjBxUWNKcTdXWG0wNHR2b1VVNlRyVllac3VVV3l5?=
 =?utf-8?B?c1B0b3g1UjZWeXpKQ1JUajF6bzNja2hMR1BYMHZoMEFLKzlDcE50RDVua1lO?=
 =?utf-8?B?NDF4WGxkdU41TWhud1M2aG15V1hwcDZEOGN3RllwOW1PYTQ4RHlMYkRoQ1M3?=
 =?utf-8?B?d1B2OEVHaWlYS2dsZjhiQVJSMG5kaHdMS1o4TmlYVGtUZjF6RjVKYkZ2NnR5?=
 =?utf-8?B?RUloeGo1NkE4VDN6cjNJODBKd1BPTFI5d1FXS2dBUWZOUmwxMXBSellkRm92?=
 =?utf-8?B?OE9SQ09KaXFtaDZ1OWRucEFYNFpaSythc0FudERMS1k3aVdFRVJwaGxPdEdZ?=
 =?utf-8?B?bkx5RVIxeldZSGNEbVJCb2tWSEg2S1R6b0Fjc1gveG9JbldWb0pYSGZhYkI1?=
 =?utf-8?B?NnhCeWZ5NkRwQlZDYllLd0NpQnRCMDFMSkc0b0RIOTVLdGRMaFJtN2lkN3BG?=
 =?utf-8?B?eUhJVXlFQkdWbkMzU2l2ZUV6SXQyRnRIMHI2RVBsZ1IzeFFvYUJhVzlJVTNw?=
 =?utf-8?B?Rjg1T0pqZ0pMQVA3NDhVaHkrUzNlQnNualppcFVYM2lleXdLRXNYZ0FuNXhj?=
 =?utf-8?B?c2V2RnplWWVZZCt2VU5OMXJZOVNaKzRKdUd1TFlVZUl1L2Y0NFFVSDI4UWN0?=
 =?utf-8?B?OEd4cGltM2FkNmZId090YUxyUkExRDlrOVVhdzdWRUtpbWNDOFhqUVgrUXpD?=
 =?utf-8?B?V24zcnRJZlIyQWc3cVExbE1wZnV4L29lWTdtWUgwbjlWMUZJbmVMMTFHd0RF?=
 =?utf-8?B?NzRmZTJ3U3FEVkdkMEEyWmZ2OEo5QmJ3d3NzL0xURTRlSlhabFRQcHh3UEpx?=
 =?utf-8?B?RWJGbWx1M0R3QVo1VkNEdWFjRDlKd3FMQlJESkl4MXV1ZU5HOHFqZ3Y5REdX?=
 =?utf-8?B?RzJxdW9jN1lteXpuaGI2V0tXOFk4ckRWTFRzQldxOG84SE5lZnpwMjdtblEr?=
 =?utf-8?B?RENUcnNDZnE5OHJ0d2JMeWxMaThnaStjbGRZdkx5ZGFxQThaSTIwTTB6b01S?=
 =?utf-8?B?am1ycGtIQVUwYUE0VW9rVk1vK09lWFJnb29ER3JLNlBLWkxwQnlTOGFkSE9E?=
 =?utf-8?B?L2tDT2lrc25sR1pta3JsYkZCUmJLdHlHVEsrY0NrWksyU1ZiZ28yOTk2d2dP?=
 =?utf-8?B?RlpBR0MwZ2VNTUNnaS83Vm9UeUVWZ0ZpaGIxanNPelFoc1RRL3Q1QjBNNFRw?=
 =?utf-8?B?K3B6cDhmbVp1bEJ2OERkbmZVR2R4RnNTSnF0YXY3NHB3T0hZZEdmcVpVUW9Z?=
 =?utf-8?B?a3F3SU9EaVFYNVRsektCMERWTnZ2T0taYy9UQnFhOTJPVEQ4dVhoVWpnV2Ur?=
 =?utf-8?B?eStiUW9wTjFlWjM2OGJ4TlRBUTRBaS9GTEhLamlXT1phVUd0U2lIYXFqZzVG?=
 =?utf-8?B?bFpjMWc1Q0laUW44cFkzcVFWM1RTNWlxSHRWTy9Db1lFUGxTQnFlaytOWXkw?=
 =?utf-8?B?Wlp3QkFSRDQ3ekQrTFVHZ0RqR2xBbHMxMTlRSmVYbDFTN1hzWE9VeE9ZWHBL?=
 =?utf-8?B?ZzhsZzJPY0IyTFlQaVlVRVZHdWY4REhsTDdRT1VORWQ0bUxEc0JENlA1aGor?=
 =?utf-8?B?cithbzAreUU0V2dyV2N1amduamdxQ2VHTFRJSENxVlgrVlBWQXBSY1JYd0N1?=
 =?utf-8?B?VjRvYmhuSHRIYjR1ak05WFI3NmwxRU1SelFRV0g4UVQ1NVBVV3o5VGYrQTF4?=
 =?utf-8?B?V0NOd0dvSjNTak5tSDBLSzZhbVJIVEMrR09ZazhyY2RFNFgyUGNsenF4Q25B?=
 =?utf-8?Q?UVnicn6dIe1cP43h4OXYjqpPk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa6f91b-90b5-4de1-e291-08db7404dc12
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 16:14:02.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqqoIb+j3RgSSEQ3h4cLjBSVQ3Km9hftHcz6sWhdLE8bKaZ/NBOWeeifSmsaO+OK0ETDh1Jtz7erusom6LOs7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/23/2023 12:01 PM, Borislav Petkov wrote:
> On Fri, Jun 23, 2023 at 03:44:06PM +0000, Luck, Tony wrote:
>> There is (or was) support for mixed stepping in the microcode update
>> code. Not sure if Boris and Ashok came to any agreement on keeping it.
> 
> Yap, needs to stay on AMD as the loader has always supported it.
> 

I don't understand this. Maybe it's a wording thing. I see the following 
in a PPR document.

Section: Mixed Processor Revision Supports

AMD Family XXh Models XXh processors with different OPNs or different 
revisions cannot be mixed in a multiprocessor system. If the BIOS 
detects an unsupported configuration, the system will halt prior to X86 
core release and signal a port 80 error code.

Is stepping not included in this statement?

Or do you mean that we can support mixed microcode systems? Meaning the 
processors are identical but with different microcode versions.

Thanks,
Yazen
