Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6931E60C203
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 04:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJYC7F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJYC7E (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 22:59:04 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (mail-bl0gcc02on2126.outbound.protection.outlook.com [40.107.89.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79513B504
        for <linux-edac@vger.kernel.org>; Mon, 24 Oct 2022 19:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuB/kROixrI7MEr5IXfCqcC3YoHW+NeHuLt78dRzTx63Kn+gr2iq0IYT2A5C5qPJlC5ErUkOJU3uyaADOPlIfYONqQ6aDM+FLiPTPyILnibVjkk5xU7oWeMpji1oO6qF9J3CpTBY5zVuSb9UVoCfTFCBrfHO+2oJHaJepw/ysgiRF/zZaBjf05pbpbasJLbM6rkFzrSVFlmxFifq7RyUcLMsEQ4ExoNwGp6NAUfHfXlTVNOWu+fP6wZJzkcC0LvbGekEvrXoQasC+mMcfGAa4zCGIxVnNX2OCtUzFRvYDzGITeCbAUXdCg1pGKBj1fsNfwee+HNCYv0X1uJ0dBUqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZtCU9b8R1Zlfa33u4lVJ8YQzA24HE6LiTDiZB0z0P4=;
 b=YteC4o5K/EUsX6apy/KZQK7LDWCvADX1zQ8enHHn94lKl4AEc24LU2X9kOkZZaDLcoKLW9DYtOYgytxXDBkVDsm+PFOiRcHHNY+c1KVEhDjtH6DovlmrDSEuwTQvZiDKyfrZlsaNfjPTTD6BwRnXQKx3FkIFISJiHCSQPIbh7xLfhwn5/3xOG+ftZ0T3jyCPDaqvA9RyQvZD3tj4OriEUjBKnbj4/cb2ZbSCo0nw7VroZ9j+tkZ8cvwiVNSZzKJ06FInqPOEhrSI1SOma7xE2+spkKajEOJEt/DlX4U6i1qOEeA8nmWJa6NnmHtEixb/vebVQSwRm2X/PIuwc7O8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZtCU9b8R1Zlfa33u4lVJ8YQzA24HE6LiTDiZB0z0P4=;
 b=2CsGnl/AacelISlEe5WKYXCadZHun8U+vmeDosyYV4FCkpApDtkgsJL77zozZYVfyBAh6+3maADnXN4b4uUUuYZ5Lmb41hcnRBGwmyaBFOgSE2G+4p0/dqCfgHkaxFf+H19Icr9iyYv3TQM8wqGYBovFILWdOiRlABb0H4r4bQBt2GOmLnSPJnmqfLl9ur+RYigY5Sz5ej1mgDmHDW37v3xRAB5vWu7PdWy2wVs8rBM2+LoZU1dsWpWg/7+veO/Ee46IDFM+k2VTMLkEoHyzG7bHsa8mSwTYwPnePa3UZ2HPu/yoglgZhWh6upmhHyCIRw+AYEd9bRr9djNKLAV6jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com (2603:10b6:a03:26b::14)
 by MW4PR09MB8994.namprd09.prod.outlook.com (2603:10b6:303:1f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 02:59:00 +0000
Received: from SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6]) by SJ0PR09MB6318.namprd09.prod.outlook.com
 ([fe80::61f0:cc0a:9ad8:9cc6%5]) with mapi id 15.20.5709.015; Tue, 25 Oct 2022
 02:59:00 +0000
Message-ID: <1233d52b-37f1-1629-1bca-162b72da22cb@nwra.com>
Date:   Mon, 24 Oct 2022 20:58:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: EDAC igen6 error messages at boot
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <11240651-e924-8d8b-c2f7-c6e031e6b95a@nwra.com>
 <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Orion Poplawski <orion@nwra.com>
Organization: NorthWest Research Associates
In-Reply-To: <IA1PR11MB61719B0624357D88C44426E589319@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000008010700000100050603"
X-ClientProxiedBy: CY5PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:930:2::21) To SJ0PR09MB6318.namprd09.prod.outlook.com
 (2603:10b6:a03:26b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB6318:EE_|MW4PR09MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 353bfa94-98ca-49bd-e078-08dab634ddc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps/RsYHnp6PIYUB6v0zGqrYb7DfRP0fNGxz4VD+7ftM8vQaznRjDqAgP37e4iURe/pXSXyrsn6Q2DkNUpxFE0WL5CE/I3tsMgBue8Sx9aZotO8g00XuYlkscy3Qk/O0cQGHI2yCkqmolo7og/Amsdg0T7oDS5yiJsOZBRZA/RGdJniiN6OVDPirbvcveq/dq3RydRpg5U4k347wN3sMdNYDm3auCrbkA5im3+uHfhV/atiRkGYRjOmniqyKvsk5RNB+Vja8B+D2R9HHc2QdBSpuzzSci5ngqJanMTBUnc4gDBaEGS+n5+P7PaqXdyzD7xxRsdJr8deZN27Y0yiWHDFn4GbcXVkBotZ/Zm3kMvkyQYETcyiZzHP6Jq9nJk1rTC8qicqExk1JUqSczoWcpN9VRiigDzXeRTc1mtwAdeZxCFfXw8O/1hsUzFblbWcSWn455ItgtDlRj5Y1EU9c4Mi15fIK1Xugim0nplMT/SeQbppa8j5j7X+GlvFhzm4xn/DrOTtD1Tq63BMgWCfFxxkWJdrA+GtgqH6Dxu3hWolhVusTjL21kOuxgMXllhM7PTieNLew4kPINa18cCXR7xloevRHPHCKzxj2ZRab3eOXddxZ1gdmnsU4dZMqKW8XWgDuUcfTjCPf+BWJoGt/LHRIIQaopP/hS1voKG/oGns60utn3yl61qsx0EWJSwfc966t9IbbNYp/XVXwCtBWQ0NOioVnfia6EuPyVhy5V3BHxaw3zXur4DnEC4lc1iyIwj3Uws2oEMUPNwZ2/Y76dtxzbwZAfL1y+guQmwZyAtmTkotY66MxjZcxhGhaTBE05UUf2CibNnlLjlM3QvtcHaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB6318.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39830400003)(451199015)(86362001)(66556008)(66946007)(66476007)(110136005)(31696002)(8676002)(235185007)(40140700001)(41320700001)(36756003)(8936002)(41300700001)(5660300002)(6512007)(966005)(33964004)(508600001)(36916002)(53546011)(38100700002)(6666004)(6506007)(83380400001)(186003)(2616005)(6486002)(2906002)(31686004)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkY2VDVYR2pjODkxcEF1K2VFVWMzZFA2dTRmQURaZVZxU1ZTdnczRUszZ2lQ?=
 =?utf-8?B?SkUzbGlEMHNYRlVyRzJJV01GMDdDaG9FRlA3c2ErNnltNDlwSXhTUGRaKzNy?=
 =?utf-8?B?WnlQQ004R3hhUnZRUHpSYThVUnVEUzU5VGN6alc2WGRrYjV2c0dJSG5oLzJI?=
 =?utf-8?B?S0lyY0Fka0hrVElMQUY0MmpaSHIyNXdLY1NRa20wdGtuYmN1UVQ1YjgxYXlI?=
 =?utf-8?B?NHl5MTN1OFh3NU8raVkzU045RllaTkhLQ1NVM1BsYlZwampXSzkrYThBM0cw?=
 =?utf-8?B?Y0pMNVNJaVU0Q0tuYWUxZkNwTmlGMS9jMjFRc204NlI5NEF1ZEN3TlQ0TWcz?=
 =?utf-8?B?bjd5YTBGK0t4Z2xuS0gvb2hiTmJxeWhLMXFoZEs3ZjNQNzYxWi9vU3ovZG5a?=
 =?utf-8?B?M1FpcERoTVdBMGo1L3VoNWhIc3BSV3QvQ016U0FMTWhZeGI1SzVmRjFaZmJD?=
 =?utf-8?B?MjhNcjFoQUIySU9ubHFWemU2WVkwVGxSd2c5RlN4RE1HaFpyZmtXQ01MMmpZ?=
 =?utf-8?B?TlhOTzFlelRLQ1dld0JzU20xWmZHQkppRU9YRWdnRHlyVEhNSis2bWluMHI1?=
 =?utf-8?B?cy9RWW43Kzdmd05EOFJ2aW1uVzFkL1Q3MkFib2VkL1lVOUE2Z2NOVmtPcWFP?=
 =?utf-8?B?YkJFOFU2UW81YVU2cnI2S1VCbThFL1R1L0dyZWpJME9VNmhQcC9QNDJpazdR?=
 =?utf-8?B?cVRxVi90bjRTSE8zMmY3UzBmbXZuYWNGd0RXOGtOOFQ5VU9LTnRYSDhCS1lX?=
 =?utf-8?B?c3VBcFYvUnZ0ZUxVNGp6cWdDTVlCZlJvcXBpRW1PWEVOM2pEMkUzaHZmY05j?=
 =?utf-8?B?ZldGTFRYZGVBWC9wbFF1eHZ6cFZoVUVPaEV5TFgvY01mMFUvR2Ivd3VRVTJ3?=
 =?utf-8?B?a2REL0g3WVZsWGJ0OTc2aDNOWlJSQTBlSklzaFJTdlJLU1ArUm1GdWpFZVhW?=
 =?utf-8?B?VnE3U2FvVStFSTZTTENiTTVjbUxQTFdlUU5jWlJiV3FYcUZFU3ExWFNEK0pU?=
 =?utf-8?B?OGRCclVkanBzeFJzVmlDaVUwcm5wRCttMmIyVUdzSWpQV2szTmcxMWU4OGdt?=
 =?utf-8?B?SUltNHQrWHlIN1ppdkxOOTFYWlkyTGlVSUpmUGZGYnJUUGlvdVpvbjZGbFU4?=
 =?utf-8?B?bFhJVUFpZ25NQ3BTZW1pTmZrcW5KMWVDQ2hYaThrT3hPelk4ck1hQmRzbHpF?=
 =?utf-8?B?cmY4K1FCVDVvSFh6a3pMMCt0bzdWUk9MWW5uVTJKRFBKVWxBNzJaSDN4M2NK?=
 =?utf-8?B?MW1sRnVPVzEzR0UzL09UYytnTlRMWGJoQkRVeXBKV1plTnZ4RW9mMjF3MnZO?=
 =?utf-8?B?RW04ZVpIV2JWdGppTGFiQ2RRUGxWNTJvZktoT0FPdUdVck0xc2EzTGtYQisw?=
 =?utf-8?B?YXVzd2w0NmpmRWNlSzBjQ2Z0Q2haczRDcFdPaEFEb3N1VWlNUVR6cjluWU50?=
 =?utf-8?B?cERZU3dVNzdkbTV1WER1dWZpb0ZrSW5zN0E4dDN1TUlPbFhkMzlOUVllL0Nw?=
 =?utf-8?B?UmV2aWZ3ZWRTeHVpNzlZTU9Gdm13UHlmOHFGVjNFbzNwYVpvT0t6NGloQWZw?=
 =?utf-8?B?OHhqRGxqNmtDWWdTNTgwZWduYjZtZXkyZmI0blh0MXlKSmkwVFh0emk3QXFM?=
 =?utf-8?B?TGlaL2FFT25xTnN6L0ZXMlB3MDRFdXQxTkhGOFI2OUt1d0V0eFlCUVpIS3hJ?=
 =?utf-8?B?ZUhhaEZFYXhZUU5RSzdhZkxzZDdJTk5lbFl4N0hoNG9QZWlKQWk0Vi9KVzFE?=
 =?utf-8?B?UWJwMitZK0d4MUR2K0t5R1dtZHdTTGRSUTVTSGxrWDRwV0hhMmdlVE9IV3k4?=
 =?utf-8?B?aFM3aCtPNlMrL3A5UzUwa3lLM0gyeE44czlkTUtFd2RtRmpadklIcDlMeHlm?=
 =?utf-8?B?bnVUQWV2eUNBMURCcWNqU3lqcHRXdGtaMFBrdU8zb0p4ZjcyNG9Vc2JaZlA4?=
 =?utf-8?B?WWcySGdpQVlVSE9rQll3bllxeTJDbmtmVGlHQkhMSFZPWkxXK1VEaUo1ZEIr?=
 =?utf-8?B?SUkzZlJRY3FZTHo5NEdOVFdZR09ucmpwRU44MktDWVlCekNpRHRlK0c5NG1T?=
 =?utf-8?B?ZkptbHMzM3JEQldMZC9EUElRbU5DRUVKZzBJYmk4N3FTb2V4YThlSlQ5Yms4?=
 =?utf-8?B?WmQzRmJQaWYxOVphK1FxQ0MxMlEvNW5UL2t3R2llRVdTaXlCR3NleTE0Y1Zy?=
 =?utf-8?Q?C1+2m5n83bfaQeTgVTq9yVVnTk5HW/Kv3URmS4Jk4yNV?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353bfa94-98ca-49bd-e078-08dab634ddc9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB6318.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 02:59:00.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB8994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

--------------ms000008010700000100050603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/22 20:46, Zhuo, Qiuxu wrote:
> 
> 
>> From: Orion Poplawski <orion@nwra.com>
>> Sent: Saturday, October 22, 2022 12:08 AM
>> To: linux-edac@vger.kernel.org
>> Subject: EDAC igen6 error messages at boot
>>
>> We have a Dell XPS 15 9520 running 5.15.0-52-generic (Ubuntu 20.04) and get
>> the following at boot:
>>
>> [    0.981641] EDAC MC: Ver: 3.0.0
>> [   31.801126] caller igen6_probe+0x176/0x7b0 [igen6_edac] mapping multiple
>> BARs
>> [   31.805272] EDAC MC0: Giving out device to module igen6_edac controller
>> Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
>> [   31.810599] EDAC MC1: Giving out device to module igen6_edac controller
>> Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
>> [   31.810616] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
>> [   31.810617] EDAC igen6 MC1: ADDR 0x7fffffffe0
>> [   31.810619] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
>> [   31.810620] EDAC igen6 MC0: ADDR 0x7fffffffe0
> 
> Did you still see the error log after you re-boot the machine?

Not quite sure what you mean.  I see it every boot it the logs.  Are you 
interested in the difference between a reboot and a power cycle?


>> [   31.811957] EDAC igen6: v2.5
>>
>> logwatch triggers on the ERROR and reports them.
>>
>> However, from some searching around this seems to be fairly common, so I'm
>> guessing they are somewhat spurious.  Unfortunately the messages seem to be
>> similar to what you would see with an actual memory error so don't want to
>> completely ignore them.
>>
>> Could anyone shed some more light here?
>>
>> Thanks!
>>
> 


-- 
Orion Poplawski
he/him/his  - surely the least important thing about me
IT Systems Manager                         720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms000008010700000100050603
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
DQEJBTEPFw0yMjEwMjUwMjU4NTdaMC8GCSqGSIb3DQEJBDEiBCBCM9QEZaIa4E4qkROt9D/h
uvq4lwicKIBaXCJlZq6BEDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgEoMIHMBgkrBgEEAYI3EAQxgb4wgbswgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEQDKIgIinUX7
EAAAAABMOfZYMIHOBgsqhkiG9w0BCRACCzGBvqCBuzCBpTELMAkGA1UEBhMCVVMxFjAUBgNV
BAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5j
b3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIRAMoiAiKdRfsQAAAAAEw5
9lgwDQYJKoZIhvcNAQEBBQAEggEAv0Hk68jVvbaNIru834GJkyZyIb4N89a46FHfnv9Q8Pbc
4549K2j/87mCcH7dQ6O44X+I7Ibp3Vy7KV3+9V6swEKlSV8zlw0IkifEjujVduYJHFZ/D6mq
3DGJmMwS/AR5CWxIxFFLVZmsrfL3QjLY3j5/EBSwAMkMaSPY0v9/7iOLR/AR3ufPWptWvMc8
lGysCsg/4CQNGiTMlT6s19rxzVYWnDaG3Lx63M3MlSRm7we8pAZN3n+hH0OoQfTDi0vw9Y4b
8zl0SINbts2uwrVZbqCFCCZnykirafHNNqAnKBf64sYm0emKhMqDUAUg9rdXApdf9FNzlCQk
cVcjT8SH7gAAAAAAAA==

--------------ms000008010700000100050603--
