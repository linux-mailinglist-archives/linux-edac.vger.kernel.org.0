Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADA61653E
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKBOgY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBOgU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 10:36:20 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (mail-bl0gcc02on2115.outbound.protection.outlook.com [40.107.89.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D326AC7
        for <linux-edac@vger.kernel.org>; Wed,  2 Nov 2022 07:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDs0M0B0cefpxpw0uotzQhUtMuxFKlffbVzG9GNT6AOTCsXAVnK7lwtjXwFKgss2hy9oLL0x9IKNfnonc41Yv9E2JQEN9A19LaUhT3UoAK6JcWrT9lpcIcKPEm+RaLAjd+SzOwNikLcFg1yIFaD5Dli6AMUN1P9A1ExCNWB16cz1Z0+Y6eRTHTOp1EAywH2NrHxa5LAcYTck8/FVJ3c0RJSp21Iu/A2zpnRhmgahXig5bTcowHYvTHhEHe0kp61N1333utwjALkArWI0/bQC3TPERs6Fcwa8Dv99GgOIeU7ZWSJgrAq3FqWP6+7NHtEStNkdZDaJpm9oiqRmo/C8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owHrTjfw3Q9NHLxYVSrEQ0jGcglOCZD+ZS0xYgnFrE8=;
 b=T708n54/pReKGurS+R8MTSIrVrHXya15qJOQbWRqbN5bNIwh+el8KLrEl8N7htFZLF2z9+JHoc4gSDKOZVMHkm8cl5TMAuEveKGXuckBwGCrFOAgrhtrc6NrsQOFnwEwhTeF6iZrD/Mw8fN8T9sUJzDKunXywK9rwz63u5ty5NeTvUrL4eDa7upMeE5GCeZHH0pYvLKUOgctSNU77qrlgambdCX9Sqg/uG9zGutERradWxPVMeM+Nk1sf4gqdmpAawl2bkeECWNYVUd6HFlM35eM2ECXClm2vvbG5OW7uU+9Mblu+XDJOb7e/6jJvWizjt0QXOaPXZN50hVHR4IeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owHrTjfw3Q9NHLxYVSrEQ0jGcglOCZD+ZS0xYgnFrE8=;
 b=4PMnYmn9R9uJLQ13RFhVHol6Hjlt30LZrPbXSoGjcRQnjjnsL3qvMTejp5LmPSaHiYPtdOxIU6VKiyN5UkdeY5PWo1j3w+SREswphfswOBmrqPrPGMc/cs+yp0D1k9swIgG6iHPXN335+cleivNTufOpWrZ2ZgMAvJMDgBwgTaLEeszfuLi/+gSSKuNIQr/uPcfCjajVF1ZSMrpdTD71abSkfHYj3Fd1Zi3UheNuM2ZGaFhVaD6rT0hluZKjExnbppoNoC4SpT2RztNJVWTNLZm2z0Azk2OFPLc+xMj/olsvaI1toPHaeJCG81xlko4Wy1hwYeEBXWe1Wl20F4wAEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by SJ0PR09MB6511.namprd09.prod.outlook.com (2603:10b6:a03:268::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 14:36:15 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::49fc:975b:80a7:63b2]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::49fc:975b:80a7:63b2%4]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:36:15 +0000
Message-ID: <5f78ed98-e216-6202-8499-dbc7e4358cc5@nwra.com>
Date:   Wed, 2 Nov 2022 08:36:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: EDAC igen6 error messages at boot
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
 <IA1PR11MB61715701ED05952113AEF26389319@IA1PR11MB6171.namprd11.prod.outlook.com>
 <46771e87-ba19-164b-a708-87165652fa07@nwra.com>
 <IA1PR11MB617155E9BCA54DED8687209189309@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Orion Poplawski <orion@nwra.com>
Organization: NorthWest Research Associates
In-Reply-To: <IA1PR11MB617155E9BCA54DED8687209189309@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms080405070302090704000604"
X-ClientProxiedBy: CY5PR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:930:16::33) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|SJ0PR09MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7483b41d-bd36-4316-639f-08dabcdf9890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8h0AIFRRLCle8u5CcwPoRjtYjkqZOFSz+4gSvMVAPvUfqFsVn1pfpkAfJYz09BeqCuNkUJrCr9fEmy3CWUASm+q3mIhP1pJjdHsywdg5W9WWjk2Vl7vefXXePyL+C8fOchdZjso1qwM/E+WR0W+eS/xLy88bNyf+AvDH3HD4pIb4UIRbGY+SlPUy4jfpVsib3pFtTGm25NQn3SRO08BvHCti+hsUa4atiCWnVoSBSDuviu7ee7ni0LrMbEo5xWnqsD2eeuFY5zrsAIQkAdhRuNJoUcPWG6z7kY2ZG/vnm//Sfqg5lK1qKBc0xKydwLCVdVW9gXpu9R9y0eXPlH6AxP2UeabLpdaYgZdEiqDPL0xV0aZGg603GXuyzfnFUT/kf/hmkODJvuhj8OCR0EreWuSlSbXlctNBAVyrxXTuRf0HsIt+HkKpIZUed+Tt0xXFEZmJrR2LgqBq6WL9GMbf1KwGeOxbTG4gQw+cD6uRsvH4zfEYwScn1RKQLj5abW0Xc7ITwB0uvN5Iedo3YWWGgiMP9auTy9vN0J1UGR2Gt94/dm1QlYO8ciVMH/EJG1lJv9iaJTpFOsvSGSgogniY3Pm5psUeyZAvjeNii2vcLEOn7lQQmXE82pqTb6GGqUwIHapvitiDBRgbkH7hDiTzC4IKXAwoNDcWI8gQA0o7oJtjv1p4CM3LYd/22oBUEPT7aPyejn+RISA8/OyoS/ASWWrpmKxP4Ayl1Ggb3JUIXhlbWzLh1BsvDtbfbJVXaH4odhrLh0PW1H4jlDodMGaL/FLFka02mUp9FOTLb8z4OALBnIKs1OfzAtobKGpyVVs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39830400003)(451199015)(2906002)(508600001)(66946007)(8936002)(41300700001)(8676002)(66556008)(66476007)(40140700001)(235185007)(5660300002)(6486002)(966005)(110136005)(83380400001)(31696002)(38100700002)(36916002)(53546011)(33964004)(6666004)(86362001)(6506007)(6512007)(2616005)(186003)(31686004)(41320700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lQUFUxeHA5ZWFUMXZXT3VKTHNsZXJUZlZzQzNkK01MNGVuR3pETm92NUdu?=
 =?utf-8?B?SDVsdS8rcGhmUVRaSDJSY2hJUUpVODA3WDdCUFJJYWRjWU82OThzWm01V29a?=
 =?utf-8?B?Y2NvWU1tNG5KeTlvOEY3WWhaWmFYWEt6ak5tRTJ0UmxneFZ6T1pHRHd5VUUx?=
 =?utf-8?B?VXcxNlJWaHhuWlFIWEVTOUJpMXF2c1FTVVZzNGVoQlVaQUR1RWpVNlZqSjBB?=
 =?utf-8?B?VmNlaHpFcHNYM3pzb3V2M0VuT0NKU2JFekcvTSthK3diOUkrZmtOZ2VJUUE3?=
 =?utf-8?B?QmpwdGNybkhFYTV2WVZBdjd5R1J1NndmOTdVc2JjSjRNY0p3dkxodHhGL1pY?=
 =?utf-8?B?bmV0UU5Zem1DZG5zTzZINmdHTi9jMm4weml3K1BYRW9hem55Z2lTOE00b1lY?=
 =?utf-8?B?SDlBaTBqTXRhMC9KZkNoTmY2UUNlSERyWTkwTWJ3S3BJRmxveWR4MnZYWmhi?=
 =?utf-8?B?OE02emxYZHd0Z3Zzb2F0MEduRndtT1g2anUxVktMRU9RWFE2NW1SbEJaUHNk?=
 =?utf-8?B?eElCdGZOYVQ4cjZtTzNJMTJ5WDRVWS92RnI4ZGVqdkRIQS9lbkFHNktaK3JK?=
 =?utf-8?B?eStBZ3c1ZnBtaW5EZVBIOGpNck9SMlhXMUVLcjZMRGo1WGdWMTNWK2MzbFBs?=
 =?utf-8?B?NE1iRVdMMEFQV1d0bjZUdGw1emp2cEVsWlZkNks1bDI4N21nR3dEbmdjZWcy?=
 =?utf-8?B?Smd6U0hIbjhFU1MrV2tScU9EOUZRc2IyUW1ZZ1VtOTV1TlZzeXpkemYwTy96?=
 =?utf-8?B?azIweUU5N1QzWGxoS0NuNWVMQ3VLVTAwZTdFekd3S1h0K2dseVE5eHVVb0k3?=
 =?utf-8?B?bC9mUmxPd3ZDTnRwQ1FSRlRjR1VVNVBxYS8va1hCVFRiWWpwYm1PN3JPd0No?=
 =?utf-8?B?WkZQT3dXdml2VDNQdWpFcWo2L2doWFZyRXNqZ0xibmFKL3JUV3hsT1gyTzdX?=
 =?utf-8?B?SVk5eHoycE9ZMW90ek5uNDhLSnFsYUFRTThHeVhXVXhuWU8yZ0ZpeXl1SDRh?=
 =?utf-8?B?elRFY1BPTy9lTWVabEFaei8wNE5tRUNTZUZOOFNES2U3OXpsUUZRMUlINjRm?=
 =?utf-8?B?VXRwTmxIM3d0MnlTMnZac2RjWnlFMFpzZCtzL2pVdkZDazRMb3NFaXVqTUdx?=
 =?utf-8?B?MHpwMHhLYXIwOCtWLzJyR0pvOWJYYk9XWjBFU2NGMEhVRGNuOForQ1hFTDNQ?=
 =?utf-8?B?bWg2Wkh4dE02UmlFOW1MaTNaMXBHc0RBYXc4RG96WDdENE1PVWVESHBvQ0dm?=
 =?utf-8?B?ZnJTUzd3NXc4bWRhc0owZkRaeEV6dnN0NmxleGhsWno2MVFHSnZkajZOWnhX?=
 =?utf-8?B?QVRPVDllaXhCTjBackMxMytFZkxtWm00Vk9ZZm0yVU9SQUY0bVRLZWF6T2tj?=
 =?utf-8?B?UXlWaUlOdVh1YlRtT1FIV1ZDRHBNRGFtZER4R2ZLQjA3OUxvVXZRQitrSWNV?=
 =?utf-8?B?TkRHOFZhU3dZeXd3WEJUYURFdGJQSkRFZFRBZWN1OHR4NG12ODFvbGRXMThh?=
 =?utf-8?B?Q2RibjhMWmJaQlFLY1ZkUFZ5WjRlRC8xY1FFOGpVUURwdHlRWW50Wlhsbi9O?=
 =?utf-8?B?Z0pUdTdqbUhOMVpadjBZZTBkclVsQ0JacE9Wa2NiUUlGVno4ZjNvU215S2Zy?=
 =?utf-8?B?dmltQ1RDbStqODJIN3l1cTJ6QzdtclFVaGtWbWtkWmNJcHVFQWpnSkoyYjNm?=
 =?utf-8?B?VEFwcTJxVkhESXBDV0MrVGRmdTI5ZzZLYzRqRDNCazdEYXZqTm80SEVQNVlT?=
 =?utf-8?B?cWlwaTI0UDhkY1JWT1R0YlZ4Sy80WkN3WHN3UnNqV3E4d0V0MHNCaUtFYkVn?=
 =?utf-8?B?UkovNlZlUlhhc1RqN1pFdU91WjE2d2VUWEZqM2NLdE0vNkJndE13dXRJTVUy?=
 =?utf-8?B?Q0xGWTJwQUZtUlMxbGh2Q05rSmh4K0lVWnV5MDlNa1dIWFVhN0svSTJCWXVm?=
 =?utf-8?B?U2J5Z1NIeTU1b1Z1L01yeTEzZ2hGcStaQnI3UjRHWmRyZjF5aVBZVW1rYU9T?=
 =?utf-8?B?L2NKNUJka05Dd0FKaU1XQXdtY1k3Q1JCQ1E0RmQ5ZlFoUWovZ3JFV0M4WndX?=
 =?utf-8?B?VkVNNENZaVljNHlDMllHRGZ4czVNUGdMMHBDcXErRFVSdldzeFdZK01pdVZ1?=
 =?utf-8?B?b0ttclJ0MVp0bWNOTk1YMzFRR255Um45Y2ROa05EMnc4c2haODgvdjJMeEVC?=
 =?utf-8?Q?mGf8WGfwtkoiL4y2shnP3iU=3D?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7483b41d-bd36-4316-639f-08dabcdf9890
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:36:15.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB6511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--------------ms080405070302090704000604
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/22 23:58, Zhuo, Qiuxu wrote:
>> From: Orion Poplawski <orion@nwra.com>
>>> ...
>>>
>>> Yes, can you try a power cycle on the machine and check whether the
>> error log still occur?
>>> Thanks!
>>
>> Still happens.  Seems to happen all the time.
> 
> Thanks for the feedback.
> 
> Looked like the In-band ECC error log was initialized with the value ~0ULL that
> resulted in the spurious errors.
> 
> I don't have such a machine for debug. Could you please try the attached patch to see
> whether it fixes the spurious errors on driver load? If possible please also open the
> "CONFIG_EDAC_DEBUG=y" kernel configuration for more EDAC debug logs.
> 
> Thanks!
> -Qiuxu

I can confirm that the patch removes the errors from the log:

# dmesg | grep -Fi edac
[    0.979497] EDAC MC: Ver: 3.0.0
[  417.538823] caller igen6_probe+0x176/0x7b0 [igen6_edac] mapping 
multiple BARs
[  417.538876] EDAC MC0: Giving out device to module igen6_edac 
controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[  417.541597] EDAC MC1: Giving out device to module igen6_edac 
controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[  417.542186] EDAC igen6: v2.5

However, I forgot to enable the CONFIG_EDAC_DEBUG option - do you still 
need that output?

-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms080405070302090704000604
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
DQEJBTEPFw0yMjExMDIxNDM2MTFaMC8GCSqGSIb3DQEJBDEiBCC+pF59jzxImL1nRdmcd1Wk
qtjdO2mhCm7W7LuqnfuwojBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEAU/EiSQKNnGa0tT8UnymsaQVS7VlAIDgtqOCeV1s+6UVU
61hWXTSFQnIu0crFG2xzHwmf8Mu278QMoNfnV1vmttNA1re/0z0oyRxExZup4iV7pZEI2RGJ
PzgYFkG/gEr7VmOsYPdAZeWV+ggWzpynuSJRkVYhxxI82wvp0N+BxN9lQg90q4JcAfMVh4Tn
rIs+REa8V+yzABuYidcq4H+IbxfhjcSRoc4w/k0A2C8goRh4ZpdCOLwrxgfSZ+6twsTsR1ML
ueUPO9rhOIrYGnyU79+vUEzhcR1GQf/NqALRi1VB3XU/UAa9ut+CcT63vsfSLmEPLk6nPji3
Sh8+OOXPEQAAAAAAAA==

--------------ms080405070302090704000604--
