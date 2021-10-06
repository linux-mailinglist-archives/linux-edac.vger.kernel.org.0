Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF1423AB5
	for <lists+linux-edac@lfdr.de>; Wed,  6 Oct 2021 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhJFJmI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Oct 2021 05:42:08 -0400
Received: from mail-eopbgr70105.outbound.protection.outlook.com ([40.107.7.105]:51780
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237945AbhJFJmA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Oct 2021 05:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3eUJxCiYY/ozbyn7oCiPlvKfQyUJ2IguyG1bkaSwakBh/27Qly4XwY335viwYEtgtd6NSGStujqci25uOORmh884wHONkejepREsv2j+F+A8JdnaWyMIDHyWWtr1hNhQGBZXp3snIbjqXoMcD4M40nZkkPGlExNukdHDbtpdodkVYULMGTeJObXRk/tf1Zeivhf3Sw/h+qi1mTK5dMqqkWo77X7G3fdSiDkrmZi/0PiWtFVyrVchTf3vpUk18DcpkCHTOmgRieGsX1uApyqnti19D20AXkIzjiX9ch+ZAXvmQt5nmgDNgzEVuKOWLyV2LVs6PDdSO+97ytikPcTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEIUxMOMAeiK/S1t0209qZIoUGLUFgRU0C736tPPzMQ=;
 b=LncFQB1MgFyzxsYzP8XljZ1b9OWfsAyHPbkEAOyrTyxw4tN0aP+GAyddohwjnguErraAZDaasZLQXaFarHGVSsFgqA9zC2GZsM08iU/E/Z7SxiHu2twcVq6g0oNrJJYSVGetZ3h0TYnNFXURMZWFQXLlCaKhFpIMypjK95WhDX+dEb7PZSWEVgiTgdP4Pw75GtbhmGBEg6+dCXDYDMfY+dpKYcJLQmnACpZuH988Wo2k3LBbidKuhD0PflhLfF8Zii/qXJ+WQ2WsAbjGfrGT7E6YwfvqyTwpV7zdxSfFqvIYx6ho8W+m7s7BWLSVWWowKAePsxd9EeydMJ6imZWPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEIUxMOMAeiK/S1t0209qZIoUGLUFgRU0C736tPPzMQ=;
 b=YZOQ58tdi3bc7DsiVXVtKnD/P8zmwHZQBlq6a4fVUjnMwoU47kwbgZEIDAFgVMFeDCMqnZ40VwZvmpG1jfpZre2NscDcKkaey4pbP6Oe2iVKgk4N1RmCZqhfBoffdyUPRQmjDhGusUqw6fwiSROVZl9cEnq9d3dUOdDwB7rAWfU=
Received: from AM8PR07MB8172.eurprd07.prod.outlook.com (2603:10a6:20b:323::13)
 by AM8PR07MB8191.eurprd07.prod.outlook.com (2603:10a6:20b:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4; Wed, 6 Oct
 2021 09:40:06 +0000
Received: from AM8PR07MB8172.eurprd07.prod.outlook.com
 ([fe80::64ca:2a20:a982:8de8]) by AM8PR07MB8172.eurprd07.prod.outlook.com
 ([fe80::64ca:2a20:a982:8de8%8]) with mapi id 15.20.4608.004; Wed, 6 Oct 2021
 09:40:06 +0000
From:   "Potsch, Hans (Nokia - DE/Stuttgart)" <hans.potsch@nokia.com>
To:     =?utf-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Glock, Harald (Nokia - DE/Stuttgart)" <harald.glock@nokia.com>
Subject: RE: Bug in EDAC error handling of Marvell Armada XP
Thread-Topic: Bug in EDAC error handling of Marvell Armada XP
Thread-Index: Ade1+aED3Du7YN7FQ4eu1n2e1053mwADVTAAASNcGXA=
Date:   Wed, 6 Oct 2021 09:40:06 +0000
Message-ID: <AM8PR07MB81725DB8E29F93C960A0B1C8FEB09@AM8PR07MB8172.eurprd07.prod.outlook.com>
References: <AM8PR07MB8172B5AB7AD5DAE78CA4624CFEAA9@AM8PR07MB8172.eurprd07.prod.outlook.com>
 <a3550d31dd72faeb6219d878cc7920dd11a1a5fb.camel@pengutronix.de>
In-Reply-To: <a3550d31dd72faeb6219d878cc7920dd11a1a5fb.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64e9a87d-8b46-4bba-6b06-08d988ad47d8
x-ms-traffictypediagnostic: AM8PR07MB8191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR07MB819154703121477C017562D9FEB09@AM8PR07MB8191.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tUzgHkm6mBIfzT3psCuVjPNlaGb2huGSvyzZuGFzeWYg93D/WJyHGliHkA3TecYQCO6YLczujK7q3vxR4cZ0wS9Bw6J5NAibNu9NF/svIHoSFdDfURVEXh27Kep0uroLfjgZBLwaW+bsFhlF8ba1pDZfHGPDaoJytDy2sw2uDmhtETx+R3xYIknoJn9cieLQ8Yqr7DzokrJ6B/d2Dc1VaNZr6hVPcKIzrfx09B84JodMhoGyaoZhj2qrF3LwfSf1LxmsA7FnG4tCmBCw9kD9NWQF3dGfVlRV6N+7V3Qcnuxhaz9wdh8XbnF7aQsFHWsi0YASH76s9R84pV8mU8Hwkhl87vH9W2wOajb5oURdcumkGL487hky2PyVuHf6PT4H1MTFkugDts5t87G/dc07PJCbow4aWzyw4I0VC22FyrnE81knOOPuzyGjQ/fuqJrK7246nUBcmghJfpzj7USRyGhlfXJxv0C8M1YG8pzzYvRqi1ONbDDVhzigz3vhU4aAUsIQGYQ1BhxzxEFq+5Gf8eVRWOLfxI0a4wO+PIax3tNSPHpyv3qF81/bvODQyH+emMawW+NL7VANn7uzsnxD03aYxuqvUt4LXX/38vOSLMtTyPN6wlcKwNvNOZVLEVX7JXKOg8boa74IwHmK9wMlX1bv9tNK7hsRSwFGEfDOylG2Uh1u2ywXHGwQZ9ybAveMyoCU60l153NXOHjJ3cVMU8d1n5YjmIpIU2U3lltMeoOUS/ZsjDDc+u27HW9MF9SK3KEWnFFANix4nePvQmmvh+uKYGbsLTX//D2QTS4W1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB8172.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66574015)(7696005)(5660300002)(53546011)(66946007)(6506007)(8676002)(122000001)(66446008)(966005)(107886003)(83380400001)(38070700005)(33656002)(4326008)(76116006)(66556008)(8936002)(2906002)(52536014)(26005)(99936003)(66476007)(71200400001)(55016002)(110136005)(508600001)(86362001)(186003)(9686003)(316002)(38100700002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFTb2ZCc29JTVNUVkNuL1hkVHVram1rQ0ZVMG1raERxbHBKZTB6YURLKzJq?=
 =?utf-8?B?SEF2TDIweEw5VmZyNVlZL1hvNi9Venk3YXBqV3pZZUxPZ0IxcVdFV2QrcHhk?=
 =?utf-8?B?VnowcERNMHRxWURETEZTR2lLNUtWVlJMckRmZ2dDVFhyL04wZTNJZVQvUHpP?=
 =?utf-8?B?QlFmWUxyZjAxZlJFSkxuQ0ppTlpiZXUwZ2t5bCswbk5HZVRVMW9QUWZubHRa?=
 =?utf-8?B?NkY4SkJreHZ2ZEJBbklXTGpvYzd2SXRwVmtkKzBPTGVEZTFUU3ZqQlhIYWhR?=
 =?utf-8?B?Z0NEM3BQcEFDOFlIUllYMXd4NkZiYVJraEJoalVZNjVRNlJrY3pNd0JTcTFN?=
 =?utf-8?B?Sjl3M1FtcVlLRnhnLzZxYWVqOWNCbW9KTHU3WGpCRCszOWxSOXNmcVBOQWlO?=
 =?utf-8?B?ZUVxZWVXWC9aODVqTkl6ay9FdkZxUE9vZ1R0VERJZXdZa0VBTFNxVWd5LzlV?=
 =?utf-8?B?K01jK0t0czZlVGJQRGlnNDkzc2o5VlVINVNuVVlyOUdMMTR1SjJYNUhUOEZ1?=
 =?utf-8?B?WEwrTEllL1NFNHd1TTVZMngvM3ZUSEI1RkM5QmtPRmZhMjVVb0ZMM1lmcUEx?=
 =?utf-8?B?S2NLZ0xlWkU2RVhId3ZJYnNvUmEwMyt4c1VlTmRrbkcyWTQrSVZndG0zUUVQ?=
 =?utf-8?B?MU1PbERNQjlnNUF3RjFGYlZCN2VUQXkxZzF2Y3pwaDBZbjJmSjNSQWMzaWxz?=
 =?utf-8?B?VlUwdzNmZG5sRlFQWXdJSmRwT1JrYmNGNkFkUUtIYXJNQWFCYTlCS2JJNVBy?=
 =?utf-8?B?TmcvbUdVeDhPTVlNdTQ0TnNpdlV3VXpTQXg4MHY2eFFNOUVkcWJjNVkvNUpX?=
 =?utf-8?B?YUNmcjh3VVJqR3BLcWVMclRVc1ZNMTRrNXE5YzI4T2doRkR3R3BxdVNEaGYz?=
 =?utf-8?B?YXBkQXJZOXl3by90aHNrc1hlclZLMS84N25PcXMrRFNiRjJWdjdsb2Q2WFF5?=
 =?utf-8?B?WTJ1OVJxZVJOMTVBUm56cWpFYUJKdmk4d3pjai84M3NrK28rNFdRVE1VWWo0?=
 =?utf-8?B?QURiZDg2OW9lZmphTE5XSTl3NFJycmJTVDFNcmNFWUtCL1pQd2M0MGhuSmhr?=
 =?utf-8?B?Q3U0UFQyeHhaMkVGZHJLT2paRDl2SmNTSklDZmhsaXJUaXo5d1JYVUhSWHVZ?=
 =?utf-8?B?Z3BXVlg1ZnQ0ZUNwOEhNQmpadGpZRnh6aDVTRlpvV3VwalNjS0wzQ3ZxTjQv?=
 =?utf-8?B?eVF5ZmxQY2VlL0FpLzlCUmZqdzN5ODVLZ1pZKzdmczNwb2QwdEJxTEVGTktu?=
 =?utf-8?B?V0xFUmpRcndhOGNvNG9lVTRVMk9UbTBpQXN3ek9WNWJkRFh1eTh0VEhnZ3BC?=
 =?utf-8?B?UytGU0oxUENHKzg1YW5mZUxWWG5OeXVPNFIzTVhveDJTNndFMEVxVFU1WitF?=
 =?utf-8?B?RFpReVkvcTFlam9lWlBMRXlMaHU5NnorZUQ0ZzI1bW1KeWxRdzBXeCtpZFIx?=
 =?utf-8?B?eFlqdTJxbi9sN0VQZkhIaWZDZGhSaVdIbitiQUZIS0VrbVE0eTNGWG5uU3lp?=
 =?utf-8?B?cFNmNTd5N3I0SC9lVU8xU2tsQUEzOHJOS1ZoelFJaXdxQ1oyaFlyVFNxaCs2?=
 =?utf-8?B?cGtJa3dwS0ZYYkZ6Ung4RVBQbUhrV0VCYkRiSUFTYzg1RHVqSDVwQVNmckhX?=
 =?utf-8?B?dWxZSEM5SXM2dHhqcUFXaFZOMHRUWWhaVUFmdkI2MHlyNFU5c2wyWm9UMFdL?=
 =?utf-8?B?dkxDanlJSU40STI5TFh4UGp3WmFzTFhIUU52NE5pVktPQmZ2aHZZd3pXZlIz?=
 =?utf-8?Q?FwwYVVIOp363BJIUUFrts6Hq9gDPFADkPKppg+k?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0072_01D7BAA6.E6898A70"
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB8172.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e9a87d-8b46-4bba-6b06-08d988ad47d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 09:40:06.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdIHcWu9CREuVrgkOM4eR/KFEVvDJg8GU/XmkJ3XalM6ubxDvwpBxRhv4vLXXTopvzKV2oWLM9LNNkDc3edg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8191
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

------=_NextPart_000_0072_01D7BAA6.E6898A70
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hey Jan,

we tested the patch and are able to confirm that it does not have any =
side effects.
Unfortunately we were not able to reproduce the error trace as we do not =
have a specific testbench to reproduce these errors.

I will send patch in separate mail.

Is this ok with you?

Best Regards,
Hans

-----Original Message-----
From: Jan L=C3=BCbbe <jlu@pengutronix.de>=20
Sent: Thursday, September 30, 2021 4:25 PM
To: Potsch, Hans (Nokia - DE/Stuttgart) <hans.potsch@nokia.com>; =
linux-edac@vger.kernel.org
Cc: Glock, Harald (Nokia - DE/Stuttgart) <harald.glock@nokia.com>
Subject: Re: Bug in EDAC error handling of Marvell Armada XP

Hi Hans,

On Thu, 2021-09-30 at 12:55 +0000, Potsch, Hans (Nokia - DE/Stuttgart) =
wrote:
> Hi Jan, all,
> =20
> we recently discovered strange traces when our system is experiencing=20
> ECC errors.
> =20
> When system is detecting ECC errors it sometimes reports the same=20
> amount of CE and UE (correctable and uncorrectable errors) or =
sometimes even 0 UE.
> Please see these examples:
> =20
> EDAC MC0: 3 CE marvell,armada-xp-sdram-controller on any memory (=20
> page:0x0
> offset:0x0 grain:8 syndrome:0x0 - details unavailable (multiple=20
> errors)) EDAC MC0: 3 UE marvell,armada-xp-sdram-controller on any=20
> memory ( page:0x0
> offset:0x0 grain:8 - details unavailable (multiple errors))
> =20
> EDAC MC0: 0 UE marvell,armada-xp-sdram-controller on any memory (=20
> page:0x0
> offset:0x0 grain:8 - details unavailable (multiple errors))
> =20
> While looking at the code we noticed that in the=20
> drivers/edac/armada_xp_edac.c file the probably incorrect parameter is =

> passed to the edac_mc_handle_error() function.
>
> Please see the following git diff which should pass the correct=20
> parameter diff --git a/drivers/edac/armada_xp_edac.c=20
> b/drivers/edac/armada_xp_edac.c index e3e757513d1b..b1f46a974b9e=20
> 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -178,7 +178,7 @@ static void axp_mc_check(struct mem_ctl_info *mci)
>                                      "details unavailable (multiple=20
> errors)");
>         if (cnt_dbe)
>                 edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> -                                    cnt_sbe, /* error count */
> +                                    cnt_dbe, /* error count */
>                                      0, 0, 0, /* pfn, offset, syndrome =

> */
>                                      -1, -1, -1, /* top, mid, low=20
> layer */
>                                      mci->ctl_name,

Yes, this is a bug and your fix looks correct.

> Currently our system is running kernel version 5.10.49.
> Investigation showed, that also latest RC still has this bug=20
> armada_xp_edac.c - drivers/edac/armada_xp_edac.c - Linux source code=20
> (v5.15-
> rc3) - Bootlin

Were you able to verify that your change fixes the issue? If so, I'd ack =
a properly formatted patch submission.

I don't have access to the hardware at the moment, so I can't easily =
test it myself.

Thanks,
Jan
--=20
Pengutronix e.K.                           |                             =
|
Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

------=_NextPart_000_0072_01D7BAA6.E6898A70
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEaMw
ggWXMIIEf6ADAgECAhMiAAAbpIKT6CclIbGAAAAAABukMA0GCSqGSIb3DQEBCwUAMIGSMQswCQYD
VQQGEwJGSTERMA8GA1UEBxMISGVsc2lua2kxGjAYBgNVBAoTEU5va2lhIENvcnBvcmF0aW9uMTUw
MwYDVQQLEyxDb3B5cmlnaHQgKEMpIE5va2lhIDIwMTYgQWxsIHJpZ2h0cyByZXNlcnZlZDEdMBsG
A1UEAxMUTm9raWFJbnRlcm5hbFN1YkNBMDcwHhcNMjAwODIwMTUxNTA0WhcNMjIwODIwMTUxNTA0
WjBFMR0wGwYDVQQDExRQb3RzY2ggSGFucyA2OTA1NzIwNjEkMCIGCSqGSIb3DQEJARYVaGFucy5w
b3RzY2hAbm9raWEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6Z8Ex9tL4cUF
3a9oyWqNuNp5nU5Kxvb0Ou/g9tc+kn8QPPpVGF56TVTf9gEiqhiFQkFBrIXjWcBdoMV+6tIATppA
ItVWMZLL8pbZjk0eNuPmVQ67lbfxqULrqvOm4TtFCtPaZgLzUltskXipi/GdWvcsBn4WG8xYCL3s
EHsNzELXMqjtRKMACdM+LXfZcqF3RwyAAEasXAYFLZel5rZDxliEDYWfr4AYmRgbEV5EOAwqsTQY
hdji3hUe2c0N4XQluOlwcgeftumbYnikeTV3zJ3KdlcfxdaJw2U5KwrEHsjIJDRWMPuiFZrVtO2A
6Kr9TZwX9FeVsL72VfwECBtFsQIDAQABo4ICMDCCAiwwPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGC
NxUIgr/FBIb67zKGkZMmgtruKIHz/HU7gZzzdobKlhkCAWQCASEwHwYDVR0lBBgwFgYKKwYBBAGC
NwoDBAYIKwYBBQUHAwQwCwYDVR0PBAQDAgWgMCkGCSsGAQQBgjcVCgQcMBowDAYKKwYBBAGCNwoD
BDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGGMIGDMA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG
9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBLTAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAEZMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwHQYDVR0O
BBYEFLV/q3JAGidl0JRCUXpBks/L9zNWMB8GA1UdIwQYMBaAFBtnSucUFY0Q26wtZOP9DUhhvKjW
MEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9wa2kubmV0Lm5va2lhLmNvbS9QS0kvTm9raWFJbnRl
cm5hbFN1YkNBMDcuY3JsMFEGCCsGAQUFBwEBBEUwQzBBBggrBgEFBQcwAoY1aHR0cDovL3BraS5u
ZXQubm9raWEuY29tL1BLSS9Ob2tpYUludGVybmFsU3ViQ0EwNy5jcnQwIAYDVR0RBBkwF4EVaGFu
cy5wb3RzY2hAbm9raWEuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAVAUwBBmxIqKj/VZPKt6Drtgog
eEI7hG/7QRSsuBUAaT4Z5IfpVcsmdcnTXXivEcYDYFqzD0eJifQufGUVTn6Hs3qhZBvF9MLTH0ay
k0ae5jPWpQt1TRO3N+3sSdg9PzFPFEumQg6tzKPNNkiJAonBNhrTTjEyBPNQaxRix/Kkf2hlV493
NwFeW9TW/1LyJFYt5XKDdWbj4z1FlbCu9DgATxDZ5xC05Jlepp2JAA0PwoH3zatETnUuAXczV43x
2tO5hSgW7mgFQORGIySznXw6DsjUafHQqha3mGQgLXHbQ6CPaVCD4VQMPjXuvf5d00U56xDOxjrD
CCWbZRK2UFHGMIIF5jCCA86gAwIBAgITFwAAAAxeE6Tbk8f0RQAAAAAADDANBgkqhkiG9w0BAQsF
ADB0MRowGAYDVQQKExFOb2tpYSBDb3Jwb3JhdGlvbjE1MDMGA1UECxMsQ29weXJpZ2h0IChDKSBO
b2tpYSAyMDE2IEFsbCByaWdodHMgcmVzZXJ2ZWQxHzAdBgNVBAMTFk5va2lhIEludGVybmFsIFJv
b3QgQ0EwHhcNMjEwMzEwMTEwMjAwWhcNMjcwMzEwMTExMjAwWjCBkjELMAkGA1UEBhMCRkkxETAP
BgNVBAcTCEhlbHNpbmtpMRowGAYDVQQKExFOb2tpYSBDb3Jwb3JhdGlvbjE1MDMGA1UECxMsQ29w
eXJpZ2h0IChDKSBOb2tpYSAyMDE2IEFsbCByaWdodHMgcmVzZXJ2ZWQxHTAbBgNVBAMTFE5va2lh
SW50ZXJuYWxTdWJDQTA3MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqGxAgN4SfueM
pqCiyXDsP/bg2WEaY07pk0GSXPR+aRQ4DBTtUfW9VsGVaWGn0FEhg0xy+dYzNxQA+V7+r7A9UyyF
DodsSFxyL/jqyCbDliX+HBdjO2s0v3DgNpvU+aTPQBAWenQNTjFxlVgkPEkYurkZj62efej2goa7
c8lIbJQKQ37OVHwLcyiPhJ3/q4vP0qggYSM35QEZB8NJX3tq2RO4uZLfDq4shjVy6ipHK5xo3eGk
6KC6m536CtwKmNrIYqtVP9CIluh6ovmLHFYopCFuvt5sVs8PyanfCxPEc58wnl2oskbNGu025VU7
enfRwkb4BYxhAv9a8ElruLpXWQIDAQABo4IBUDCCAUwwDgYDVR0PAQH/BAQDAgEGMBAGCSsGAQQB
gjcVAQQDAgEBMCMGCSsGAQQBgjcVAgQWBBQY3fXLcZydGunUoGtNB1fK2iQjhDAdBgNVHQ4EFgQU
G2dK5xQVjRDbrC1k4/0NSGG8qNYwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwDwYDVR0TAQH/
BAUwAwEB/zAfBgNVHSMEGDAWgBSZRbtXOfCHuYFJMNk+V3lf/FCe4TBFBgNVHR8EPjA8MDqgOKA2
hjRodHRwOi8vcGtpLm5ldC5ub2tpYS5jb20vUEtJL05va2lhSW50ZXJuYWxSb290Q0EuY3JsMFAG
CCsGAQUFBwEBBEQwQjBABggrBgEFBQcwAoY0aHR0cDovL3BraS5uZXQubm9raWEuY29tL1BLSS9O
b2tpYUludGVybmFsUm9vdENBLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAhJb6coFMmgxvVJF+pbB3
LEkCeEIqoIiF34SQt/nqXXMbYTA9Dzzk6K8/nvO637qAyIXZBB/Dnfb+acopienuCTB35gS8esVU
mZzseKFmmI4cbyEnrfjGDno+psXHUMf+DwdmRvqmveCy7HM+uNFS1pCG/GqujjfM6J5B1wRPFwOo
sM5Tayl4hn+3mKZzQfnWg2z+UHvX4l/lzNQAQvjV2MxLiN1YS+esS0itKJcm8paGgcoN9FM0iPCk
9/dmLWH6UYq9n/OQh18XgQHYijwrHSDHUxFW53EwYHfJTM593/C7tROvK1iE6a+GSHt+J0j3R4fy
IzEVV9bzW68vsDcQmuY8urXlBx6D61pctXZCjK7PEaD+VHaWTp8xlEp8Rhcn3Pf6w22I8Je0Twoy
6/l9vgYwu4Op/qcf/QXPEcI7S0f5U4rV4OBJA4S4zOUydAbe/k6/IzbOxf20tOcsUzurvZy8NB8/
dq2q9wRP/vn+NUwsYtfam4U+hWoLOyQSpiPNI7P4RjlD5FIysTrQvWFk+EUePedyjsXfNSbVj075
CbAy2qVOadGm/XG7JU1v1WDQ0g3aZQ15XX3+vW8Mf0oschPyU3Z9bO8Mt8gPg8bn9a05FshICP2L
5P+akAsNTViFAHWSFYAZdgkLadoNGa3yyRiDhAaqhpK73/Dn/1pWvZwwggYaMIIEAqADAgECAhB7
mk3QQ6U4rEAbHvjhGyQRMA0GCSqGSIb3DQEBCwUAMHQxGjAYBgNVBAoTEU5va2lhIENvcnBvcmF0
aW9uMTUwMwYDVQQLEyxDb3B5cmlnaHQgKEMpIE5va2lhIDIwMTYgQWxsIHJpZ2h0cyByZXNlcnZl
ZDEfMB0GA1UEAxMWTm9raWEgSW50ZXJuYWwgUm9vdCBDQTAeFw0xNjA0MzAxMDU5NDZaFw0zNjA0
MzAxMTA0MzZaMHQxGjAYBgNVBAoTEU5va2lhIENvcnBvcmF0aW9uMTUwMwYDVQQLEyxDb3B5cmln
aHQgKEMpIE5va2lhIDIwMTYgQWxsIHJpZ2h0cyByZXNlcnZlZDEfMB0GA1UEAxMWTm9raWEgSW50
ZXJuYWwgUm9vdCBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANez8PrsJ1UQxkWR
9KNK+tlaIKtfBoHTJyxQVFpR0GxeftVV1uj+p3ngGRTb53onpKZ8AFZTa6UXBChaxSDfgxRGk/sd
L6+2WSPih2JCuG0oLfj4orwTcltrh1ANzmwFAAcbd3qUxSy4MjAqcgSD3+sYz0BO+oG5v1I5cDwI
KMGjk/wJXDKcnEy7MhnExE1EfpxwMxD3Cor/mzvZlmh0aXfTfrrLozr1eCz7Y2Vi47pukN7nb7Ck
lGpYXNNkmIG/C0Anbd0N7FmIv60IMr5GrfeWZ0dxfye3kCHJ0co0XLOE+3ilYUDam0eG33Ng5EdK
nzf0fEsJFiH9MeKe35POInN8okagI+C8ABZQtZS+0dkTqxR6LAQHShtMr4xbvDSUieADIbT/wq8b
e/2dSZLrc/V8Og1gwCgtrnjAKNlUf/lXeoogUq3DDrtMHkpMcN2NK0xsw8moZPzia91lP03/7g8b
z/AE7axOBfdZfoVzu2DZZHSdeC16Ox5KVbZSyDwFpnuF5Gd/XnnvIzU2q6bpoEXapMoOCBtDpNlo
ExSz7BMD6DLYkO313LNx3SKxWxVVtyw95NcpcUtmb1zubxQ8wweKGuBJGubDUgg9K2IcgBmB3+wi
ATL6HclDvX8bJsf1SR812gBvzP5Lq2fkrWSAFz8mVP6OtXDDQBwMDSbG4MmNAgMBAAGjgacwgaQw
DgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFJlFu1c58Ie5gUkw2T5X
eV/8UJ7hMBAGCSsGAQQBgjcVAQQDAgEAMFAGA1UdIARJMEcwRQYPKwYBBAGB3ioBDQYCAQEEMDIw
MAYIKwYBBQUHAgEWJGh0dHA6Ly9wa2kubmV0Lm5va2lhLmNvbS9QS0kvY3AuaHRtADANBgkqhkiG
9w0BAQsFAAOCAgEABOWLMVDtlV0DT6RuhFNGWQW3YY6y3nLwY2SrX8PPPbiGzaybALY1y3VYGybw
rbZKSsWNgqmQ20j9+eJA3fkGdLHxZRRkyqFaA82ju2qQRtVM+GiQUe/1bRZGiZmXmAPw0Ck+sx8m
w4huYn78qtS/sGcVFAJKk27ObVkfsPFinn1B0iEcI2jYqYiZguDVrL2JZpU1jL7tTRcnhW62e2vY
ENulWAuVl9bBGizZbfl5kKC/zakq2mBT/WvGeUNHx/P/nmdSnwdJYZUwoouh++BKWuiFYVpvdwvx
mItByq7d8IzRiFHH0qGHU55d5SqL0Dg7TM8c7dO6fI1kvp87ZVBm3YjYzIEykLO85jCjYK+epOKs
LhYP9hueIre+Q/OLIj7vvHWkMemZkDOcKe5OVQcG+qN4ntkoYYFWQPdglFOWbMwhDNQqHHARfx7q
EDtKU+SfIpZQvg/+NDjT/74XnsFaAwDy5/Dj4090aVC9T6/r4DzE8xzPAoVGQBX/JoxQXZxnWgWO
EXIn9TZvSI69wI7Q8HT+KhsuuvoIOZHZpbEXmPc39jDbFh9rM8HrD9v/VbHm6RcM0HAdKI+dU0Hw
KrFK8WpZAoU8jsue2iXGnIi5Zym/ZyN5v5zeJ4P3CtG3YZGPNn8YyjgINlHWTy6dQ0sO0x3EOFHO
rm5RE5qc6yQ7KBMxggRXMIIEUwIBATCBqjCBkjELMAkGA1UEBhMCRkkxETAPBgNVBAcTCEhlbHNp
bmtpMRowGAYDVQQKExFOb2tpYSBDb3Jwb3JhdGlvbjE1MDMGA1UECxMsQ29weXJpZ2h0IChDKSBO
b2tpYSAyMDE2IEFsbCByaWdodHMgcmVzZXJ2ZWQxHTAbBgNVBAMTFE5va2lhSW50ZXJuYWxTdWJD
QTA3AhMiAAAbpIKT6CclIbGAAAAAABukMA0GCWCGSAFlAwQCAQUAoIICfTAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTEwMDYwOTQwMDJaMC8GCSqGSIb3DQEJBDEi
BCBlgdk4Qec6Tt9gQBR1uyb/gE7LfBTmMUMR3WmSjc+uXjCBkwYJKoZIhvcNAQkPMYGFMIGCMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCAjAHBgUrDgMCGjCBuwYJKwYBBAGCNxAEMYGtMIGqMIGSMQswCQYDVQQGEwJGSTERMA8GA1UE
BxMISGVsc2lua2kxGjAYBgNVBAoTEU5va2lhIENvcnBvcmF0aW9uMTUwMwYDVQQLEyxDb3B5cmln
aHQgKEMpIE5va2lhIDIwMTYgQWxsIHJpZ2h0cyByZXNlcnZlZDEdMBsGA1UEAxMUTm9raWFJbnRl
cm5hbFN1YkNBMDcCEyIAABukgpPoJyUhsYAAAAAAG6Qwgb0GCyqGSIb3DQEJEAILMYGtoIGqMIGS
MQswCQYDVQQGEwJGSTERMA8GA1UEBxMISGVsc2lua2kxGjAYBgNVBAoTEU5va2lhIENvcnBvcmF0
aW9uMTUwMwYDVQQLEyxDb3B5cmlnaHQgKEMpIE5va2lhIDIwMTYgQWxsIHJpZ2h0cyByZXNlcnZl
ZDEdMBsGA1UEAxMUTm9raWFJbnRlcm5hbFN1YkNBMDcCEyIAABukgpPoJyUhsYAAAAAAG6QwDQYJ
KoZIhvcNAQEBBQAEggEAfR47cJjB7Vp1DltVgUhByeFOMXZnXw8/YPvHuoXvJyP1Vi24G7DULeFf
ArJGZCWgNumac5epYhZONTSmclZW7vDqZNwGgvmypKs3B3DWW2btqSoi9kaOG+kERc8Wp0noSw2m
OWnVos+grXjTN571CCKwhfBTY771Bs+acdvClJXGcwi090eSd/HCMkyhFAf51HyXWvo82c2nmA8C
Za208MQ0M0BWMQ1t/bGNDkiWjQzRTk889OS6rkJoh44Dy6rURiz/KBfaXy+WeGp3g4kexcbMb57N
H6WveV/oYvVAW4jq8bTnr6l2RPsPN6jCk8/ecqgVk/jRqwAsZM6J5lFclwAAAAAAAA==

------=_NextPart_000_0072_01D7BAA6.E6898A70--
