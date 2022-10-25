Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4960D093
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJYP26 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Oct 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiJYP25 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Oct 2022 11:28:57 -0400
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (mail-dm3gcc02on2101.outbound.protection.outlook.com [40.107.91.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9B147D22
        for <linux-edac@vger.kernel.org>; Tue, 25 Oct 2022 08:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqNTd56S+WLnZAY/wNfX0w7vxJ4/MxtxxyXb74P1Od4R9Kb1gATVAzzkl92FzloU7MQRelYJ7nziPoZWj68BYjPg/ldhSSD3J7JWv/3yaCp1HWys6E7Yd5OOxMZcOcoTehLAdZc7lsBQbnKB1vtTLj1CIyyJV+iBSjuawsLVNfZVEjtObCFCyTKP3dgwj4YAZhXkDYvp0klGvaxj0beqEWk/iVffXr+ixMmrYSyT7OAT1RPJsg/xPsqUusGNAWfl44RgFvWb7DLTYDjbiVI+DMpveS/7jy2o7aZy9LkW9Ny0+MQCHRysas4Jias0HIADUssBvUfDT8/nd4pMNZY9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dU6NScvI5QQ59bB//CFVO30cxVePH/gmSBINju600s=;
 b=oE/6nS5OSulwUCsICzY1++Cf9d77/lXfQXXiMrTq+pq/wlvbz3o476o3kF/UlicVAsibai0A+eSs/eVefqS5q9fAsA0+QTo9KSyiUyDveYm8tRvbTOJqW2IM2pZYd7WsCDHXZA4fm3n+axpUglx7MMAma66HWFVwL/1gk5/cpUCnZyG/izRSeI06IaXDSZxkTdjodvx1kcXeOZZhmKrtwEKJ+NeRt5g3LaUD0D6+xqnOC06eRU3/4ttoMFoYJeiz+jSkGuc4myJeZv70hEoJn3EGWcFztq/LhuXG8EGwis2MScM/700fg1An62+oJJR78sEqHg2S1oZYjur+Wd5/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dU6NScvI5QQ59bB//CFVO30cxVePH/gmSBINju600s=;
 b=Mlxlw72XR6UOF3bqcKLsRRB37M3UgOQocZW/zn6fVcsn5cKKels3L3VvO/DT9ee8Z0OmUuDqvZq3o6a8ih80cBRYHuHldz42h7gpfafshA1pop2W1IeUL9QhCkGO720v+YKODfhiWhd9G3aOHTlewm/H5BaPRGfMlfelpRoV29l17E6ta/RQ3fEw3AgssIBx6DKzM+QWcCj3uu5bKugfwv3MkgL9GSJoT/1xp/JtTIztFNxQ4upzwM0i0YcMQ8/gWEqHoa84jIqpmr29AdOq3v0EC5U+BlIX4CdAxYVc3FfwuclWUZTXfLT+xOR4N2LKi8cioRvBC6ztgvnwSgU+1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by DM8PR09MB6966.namprd09.prod.outlook.com (2603:10b6:5:2f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 15:28:53 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6%5]) with mapi id 15.20.5709.015; Tue, 25 Oct 2022
 15:28:53 +0000
Message-ID: <46771e87-ba19-164b-a708-87165652fa07@nwra.com>
Date:   Tue, 25 Oct 2022 09:28:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: EDAC igen6 error messages at boot
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
 <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Orion Poplawski <orion@nwra.com>
Organization: NWRA
In-Reply-To: <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070607000102090109080001"
X-ClientProxiedBy: CY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:930:10::35) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|DM8PR09MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 149eee4d-f297-4f36-0712-08dab69d9fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzGJwvukfGuiJvpl3I/Jp5LLSyp+q5if1LlE5S3Hjutw3Kx6R8XSGFnFB9DVJPwg6/B8+LhHYNfvlCdCppMEPVoP34z8vx588HcCe2MeYj/q1GNJu7EnsgU0IGIxz70aSdL7D73wpf1Y02+U8wH9OouflaTuybcHDskHZcf2+QnftevkRCIQFw+7hoxFp2CSgY/VkGOwaiwNKEBcoWano4gV7WHcHnoD3pSbZ2GA3QQv71gwMHR31bp82UvSsVbZzg6jT9jKTe9vnTUvr+Qkg+CJjaImqCsIzAfp4RIiKSNP1rbHYf4n08GkJXvkMZiFpciOOjjZpruUhlY6VVsuSNQM4WD2ci+lH+p4yIMunjUS7RrM49D88xDwT0CSX+29XfAyJgZjExvDhXmSc6K6jHquAIkpzwTD2yuHUb+q89GZS9t8bN3BZVZFGcqaFCpJy8uqg4tsEyfgcTFRWumfiDLyPYLH30s5WYdbpG05Gwl79B8zMuAB8lptqAw2tKOXhB9KFCNAOjN4jWob4Sw/qQI/v2NCx/dVua5dE86UE9bnFwlOtOv7B8i6JnT4Jl9M2AieiFH0CCxA/tfxg6KYx+pjw+FNjJbdoZh4lTPP/ij7Ji+2Q+i+PL53JZoLtdHpMKIkUxiLKVsz/As5Ge2FzDpJFN7vfjoE1OXK7M05/4euRNi+nIH9U/0DJDWwjQ75enkO7CYXAF3tmETxTkpmhDdVP/FJbisR0isBZUYSKWd9YLvPmcXd9YqBCvsjX29unkQaH7RiTTKHDSQrdJCBPdaI5bMWDNXWTYJKkDmiiWq9901wKNsI0EPDGzTGFu1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39830400003)(451199015)(66946007)(8676002)(38100700002)(235185007)(5660300002)(2906002)(66476007)(86362001)(66556008)(8936002)(110136005)(41300700001)(31696002)(26005)(6512007)(41320700001)(36756003)(186003)(2616005)(966005)(6486002)(36916002)(508600001)(33964004)(40140700001)(53546011)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNpRk5JT3RHQys0TDV4RjhSNmIwUnMwQlNTbFo1R2FyUzJGUHVadkRGUEJC?=
 =?utf-8?B?ckY3aStjWm54aWJOZXJNTi9RcmtJc05CZ2pQSHhlUXYyUEp4M2QwMG9kdG1m?=
 =?utf-8?B?UVA5Qi9UQ2JKTFJFcGk0RkQ5Wm1XNFBjZnhkVnZNYXY3cFllRFV1N0ErQVBx?=
 =?utf-8?B?WVdkVUIwVjhNTFI2WTlUTGxzVnRjc0Q2VWx5Z09ENlJ4Y2c3blZtZ2g5Q21Z?=
 =?utf-8?B?blBFU3E0dUUzTm45TFhXVE5WUFluZTQ3SXFYSVBCUklHeDg3NmVJcFhhTGJD?=
 =?utf-8?B?cjNiYWNDcUF0aTVYalBqWkpuRkVlQ2ovL0hSUHZJK0xFSUtaSGE1Q1hlS1k1?=
 =?utf-8?B?bnZWeU94KytlYTJML1pZejFwVUtlVFdQUGtmQmtGR0JPN1dZZUI0MWFQZHNm?=
 =?utf-8?B?eGdxVjdlbDUvbnhKVzFPWno5b3hDZEp1QWJYUE93Vkxhb0lwUkZRMmpjemN1?=
 =?utf-8?B?TjdTMnhZWTRkQmVtN0dJcXcxRnY0Nkh2MTRCZnR3MGlTUW40SDUrNXVjZmlV?=
 =?utf-8?B?SnFmTHBiaEcxUUh3NE1rSmluQjhFejZCeTl3MWRxU2QrSVlqaDZkcWJVdHI5?=
 =?utf-8?B?UVZXK21ZTGVpY1dCMHdORlFVOHJ4OGJ4WEJieDI2UldibU5rYVBGTUxza2FP?=
 =?utf-8?B?K1o0Y24ySjMrTU9DeksxTWIzSmRCSjJMUll4bFNqQnZHd0NtYWk3RTNCcFBD?=
 =?utf-8?B?cGpqdmsvbnBmMDJMdFF1eFZVS2xWWUdBMUlDNTJiMkppdVorbVRwb2VkdXA4?=
 =?utf-8?B?UUdac0REWkR2d25QYlVMZnRDelRzMXNscWxRTnFlWEwrREpkbVk4elEybTRS?=
 =?utf-8?B?aXp5MlBFY0pTdzdlVzc3ZGJoY2dhczNoSGhpWmc1T3NpcDlqUFB4UEtnQ080?=
 =?utf-8?B?RHAzWEJIaVoycDJtVzlsMzI1Sjd0T3Fpd1ZNYVVCV25nMDNjZmhNdm45eXVu?=
 =?utf-8?B?WVVQUXBrREZiTFdNd3d4b1o3S1VYR1RCN0lBUkxJamdKN1RhaE85WkxqKzgx?=
 =?utf-8?B?TXNwemlhRDF3NXRUR2xnY0wwejhMUVBTMTliL25Za3hwSWhGeFlEZ2ZhL2hi?=
 =?utf-8?B?Ri90WjYrNEFGa3M5b1BId0UvRUVheGFDYXV3QlZ2dDVsQUpqcnZtSmZRNHRv?=
 =?utf-8?B?RXYyNXNqbExuRjhYcFNPdnlMRjBwWTFUNExUQU9zQ0c3NEtac2gvZnhqTWJJ?=
 =?utf-8?B?SmlmeWw4czZnenh3bXFlTGRoVkUrT05xVkhHNC9ydkV3Z1N6MWYzbkgyS0VN?=
 =?utf-8?B?Z1BkSHVWTTJSMDFnYzhGTEQ4RkxqT2EwYVl6aUFZc3h5WUpzVVVRWGJiYVFO?=
 =?utf-8?B?THFMMDBkNXIydURmUC9kL2wwR05wNk14UWl4LzJQQlRoMmp4U09HU3pHVzVM?=
 =?utf-8?B?cWlZVUJ4cTJFOTJCcjVpMm9rVExPU296WGpVTHdCRE92UXpNcGREWmZwSHJa?=
 =?utf-8?B?ZGQ5blpNc0V0WS9WaWNXTDlINy9TZG1QbS95aFF0UmxXSFhocElrTktLa1lD?=
 =?utf-8?B?UklWTitnU0xEemdFSkhvNml6SWljZndUNnBCdkZTbEM3RWFnWGdFU05IQTA3?=
 =?utf-8?B?OUxoZ0VyWFN0UkpTanJwOUcrSEJEWEE2cmsyUnlwb3dreVViUDlxaERpTS9R?=
 =?utf-8?B?ZVJSTGJqKzU3MFdWbDlyUkwzYU1IMjhMSm5FS3c4cWYrOXMzZTNveStOOEJT?=
 =?utf-8?B?cDFaalIvMlV6VnZDSFZsK0xkalNhdy9rQnF6R1NPNzNhOE1Kb2lFV3hGWW91?=
 =?utf-8?B?SHRTbi9VQ1ZnSlB5SVcraUhsRXpGTFU5d3J1R0E5Ym1pY1ErZlg3Z3hGZm9T?=
 =?utf-8?B?MTV4WWMyYzFFRzY4WUtyTHpKUkJkb2Nwck0vVmhJWFVOWWhleEc5bWRJbS93?=
 =?utf-8?B?QWNod2RjNmtBaldzS3huSy9pY2V0NnJFNXNNUG1JOFBxSmN1bXh4Zlh0ZDZ5?=
 =?utf-8?B?VldaM3ZwRmtvUHBFTWRoTmE5WXdwQ0JoYWV3aVV3V3pvYlFaRnlwT0c5elVR?=
 =?utf-8?B?YitCK2x5ekg4Z001L082MGpMcGpob3ROK0t2M3UzWXhDQnQyRWYwSThyNWRR?=
 =?utf-8?B?TEllRDFqSTdKM1RzRUYwUnNMRzJrdFowV2RucFhDSW5yR3h0MFBBc2Z1emVw?=
 =?utf-8?Q?1l293YojoJcrvgnYIgkCmdyh9?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149eee4d-f297-4f36-0712-08dab69d9fad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 15:28:53.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--------------ms070607000102090109080001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/22 21:13, Zhuo, Qiuxu wrote:
>> From: Orion Poplawski <orion@nwra.com>
>> Sent: Tuesday, October 25, 2022 10:59 AM
>> ...
>>>> [    0.981641] EDAC MC: Ver: 3.0.0
>>>> [   31.801126] caller igen6_probe+0x176/0x7b0 [igen6_edac] mapping
>> multiple
>>>> BARs
>>>> [   31.805272] EDAC MC0: Giving out device to module igen6_edac controller
>>>> Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
>>>> [   31.810599] EDAC MC1: Giving out device to module igen6_edac controller
>>>> Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
>>>> [   31.810616] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
>>>> [   31.810617] EDAC igen6 MC1: ADDR 0x7fffffffe0
>>>> [   31.810619] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
>>>> [   31.810620] EDAC igen6 MC0: ADDR 0x7fffffffe0
>>>
>>> Did you still see the error log after you re-boot the machine?
>>
>> Not quite sure what you mean.  I see it every boot it the logs.  Are you
>> interested in the difference between a reboot and a power cycle?
> 
> Yes, can you try a power cycle on the machine and check whether the error log still occur?
> Thanks!

Still happens.  Seems to happen all the time.

[    0.975306] EDAC MC: Ver: 3.0.0
[   17.052613] EDAC MC0: Giving out device to module igen6_edac controller
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[   17.054293] EDAC MC1: Giving out device to module igen6_edac controller
Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[   17.054311] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[   17.054312] EDAC igen6 MC1: ADDR 0x7fffffffe0
[   17.054313] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[   17.054314] EDAC igen6 MC0: ADDR 0x7fffffffe0
[   17.056192] EDAC igen6: v2.5

-- 
Orion Poplawski
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms070607000102090109080001
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CmMwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggVGMIIELqADAgECAhEAyiICIp1F+xAAAAAATDn2WDANBgkqhkiG9w0B
AQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsT
MHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0G
A1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAy
IENsaWVudCBDQTAeFw0yMDEyMTQyMDQzMDlaFw0yMzEyMTUyMTEzMDhaMIGTMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEmMCQGA1UEChMd
Tm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9uIFBvcGxhd3Nr
aTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAxBJrIv9eGtrQLaU9pIGsIGBTiW0vZIYmz+5Eoa69sj6t6QANvg0IuVgWZajH
2fu8R+7m/AbZ8Wsuzz+ovtDHiVqUGvGzYyN9a5Ssx94SwNp9zLPfdCRMdh3zJB7gc4GYE/fA
kMkieO8u05f/hSyf9zU5gpjl7SW6p8IjkoyxNOr7KCbI4CQ3+1LG8pn6tz/QJwQ/BJZa4dE0
asXfNlZf5kZtyWtJhwub76zH5uXeODDxY3RooWj1l4V2fQCoFX2ov1ENUW4hRov1cMAD2QHJ
KL0Boir36wISvzq8Z65MSMCGNRiWwRaclVwVZ+QYnlhGZ0g6tMvxVrK+sHnxxr/LOwIDAQAB
o4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cu
ZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0
OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5u
ZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaA
FAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSpChQTknhqMfb9Exia9G14q4j9ZzAJ
BgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQA15stihwBRGI8nFvZZalsmOHR954D+vrOZ
7cC0kl9K+S9u8j/E5nZd+A6PTKoDpAEYmPUYpe45tZLblnvfJC0yovSIIMTo1z3mRzldHYAt
ttjShH+M6s3xrqDtHfNAwt3TCf6H83sEpBi6wtbALfkIjKuDitgkdZsyUURoeglaaqVRhi2L
5wOOChQAyfsumjT1Gzk9qRtiv8aXzWiLeVKhzRO7a6o0jSdg1skyYKx3SPbIU4po/aT2Ph7V
niN0oqJHI11Fg6BfAey12aj5Uy96ztotiZRQuhWZPOc4d3df2N8RsdWViBp4jXt2hQjNr0Kw
pUPWRO/PENBVS1Uo1oXfMYIEYjCCBF4CAQEwgbswgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQK
Ew1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29y
cG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4x
IjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7EAAAAABMOfZY
MA0GCWCGSAFlAwQCAQUAoIICdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMjEwMjUxNTI4NTFaMC8GCSqGSIb3DQEJBDEiBCDe0rcOBBoKjNkOZkr1ekBd
epTI5kiDEsmqkk/QeYXjXDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEAFSnRvqBdGdlwCbhB4T/H4jiQx+rEjXT/2upXS6QAwN1R
cbzeRNiQ2sFYKoydZIjbx+LBMdP6CsSnuQts55JxSDnB537YCQvTAnH1P1dq9OTnccCwq6pv
XGG8tCrsSqYPQqwPWWRr4D6GFbdrVu5ZheWGFeMQiwhGuVuRjz+YCOas3a8I8s1ZA1Vz5dIl
yR+x3F2eb7dFuqcladHdymew+H1vQ4ZQ5H3qh6nP9JnwdNdbUycJP+6Cv0ARJNvxnD0VARiX
49aaPSxElUN/M8CW1pFWcexSq/muw8fAdMvS0O0W6Qs3fPq8bOhpgCwrA7iP53PhoI6V0yeQ
W5GxksnWdgAAAAAAAA==

--------------ms070607000102090109080001--
