Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F5F5833A1
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbiG0Tar (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 15:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiG0Taq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 15:30:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4772BB04;
        Wed, 27 Jul 2022 12:30:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJObdw029878;
        Wed, 27 Jul 2022 19:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RL4f3s9PHPYXisFzkPBHHhKNDumYwZ18b3bWTD/whA8=;
 b=XwCGq0WXZNlNpUEX2/J+XzSamfFfkqqBKmsZF3lymy6vCQeqhAvLcAcRDHxmPuNA6Dk1
 rUZjJyfQMtNwzvOiU6EUH0jD3gtyT5DgWdGTjpsPFo08IORfdw+BloPTZxvepE+1nbW1
 z6eY55XECNZe45aH+yzV4ACORqfbouj7DuD9DcRpxuCTPhCJRAgelkL0kmIk5IG/9N/e
 hFm5yj1txeW62cq1Q3aQ4bhlecaGiLgu9k2piIVNTV8F5PczJNvp5BlrUH1ZCPMCvUCI
 H2VwUWF0X+w1gM24Fb3gA9/c7ttP6Q6q/tLdy2fhBUOEx91wDSgcmpMMPdX/oZH0hpVm uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsu1k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:30:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJL0ee020567;
        Wed, 27 Jul 2022 19:30:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh639r8sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 19:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHdREovb6chRrGRlXJtMQU+tm+xqGFy938bGyLcmWyjWzPE1kWgcBOE8l01F+3mKyj4HDacOB29TdQdyv74RH9vBK9Xupr53KUkZ4QFcgwIvDEzpMc8fY69inF+mEKcCrYiSr+hHCllwnuu6D2M17wbK6DZs8B4VY6qS1O4mHoEMUmCxRRq4XBBuVCiULHmn4ADTckG6sbVOLTJaMNRYRJOmTQZXzA2MSw8QKTvXQ3ruhmnZvwbdVkJ8HbdLyqfgWtfEjo1bl78aXCFPpoJVA4usMvaz8gQoKI2JNnJ8LXr3foozrlLKunmAf88JvExI0Tb0QpRs27rp5Lj1/b5K5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL4f3s9PHPYXisFzkPBHHhKNDumYwZ18b3bWTD/whA8=;
 b=bEZuTdqnlUe3RJ6fy5xozwuGq2OQSX4MsE5wNYHgIh+VLAV5zgyT4+/iShX2lCOb1Q/mv6aebq/Bb92/Vl7dO14aBjZUYQWdmaSo5h5CnS6ppT2m0RKJTTjy1lyyJP6ocZcXiJQEXfXzDcz1Fzlq/38B7WHlRdOBIc7ZQrVT6JBUKA+1LQ1v7V7LGA84AQ8Lb+GVTDlZoxh/B2rgylRz4ybG3zD8KL9dwu8xvgLbpr50cu2gZghnx121plfjqfCkLkUiyCcnEhtw5kAgIeFTdAjZR3lEtfai87pDVwa+XCk3b7vOcTInvZ/JyxkDtb0BCAomfC6YRxBa83/H6D+gZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL4f3s9PHPYXisFzkPBHHhKNDumYwZ18b3bWTD/whA8=;
 b=s8YqmoFBshl61iS1mIDrifVP/FKxlLU6jF8mpxRIhNOcAu9NmgY1HzsHcZkdsQ36eYkqjtUuD7uCNg7xvDuNJFdnfed5v0Vp9HKCrk4A62wfKCVe5UFSkDDYRngVCzyxAhXK9Qnn1hRJU5QuTdiste/9yNkYYNDcsg0DtLipyzQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 19:30:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 19:30:16 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v4] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYoek9ERW6GrarlEiLoaZlsaluTK2SkWMAgAAHxACAAAGfAA==
Date:   Wed, 27 Jul 2022 19:30:16 +0000
Message-ID: <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
In-Reply-To: <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859b7e2d-909c-4c7e-f8c4-08da70066f60
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GduSctshrsq6uoRVOCxnos77AGfDnrCEGl18XcMX7jp80JErOvVB0fjv4VLCkNJWWT24Ortcc5KPij6PE9uT6Dp/F46tR0SeMGWYipsEGiEtupIMZsYgQ1iPvPuiFqSssLQHDe5KaBoV6fme1BjjuEq4eqq2vf7QfG910i0kxNFPlwlcEJYVSmHSkNqQRIpdg9sy72V1NcXLzLC8BMwVTF8VQOCZ+DvNy5qS/mp/2zOeAoF4Zy3YUoSdgHPr2MT6ZgpJZ+6wc5XTJUCMb8hYm7BexY4yZsJDE8JdCJpwjFBM9tSv6GkfjnohuLusjr3FxvLR1ezTzn3T32mLSbnR96Ar9A0q7RyjD0iKiRdH40az11yVt4JdWsaHuTAM7hww2pP7OsStAScpVj3yNRst2gO5tmXRC8QquNS3vZFv8HSdtGs5TGgRHRfDl3zvMY+pXVaO9VVFwEj8+3L2gMBFbHwbRuB/PnTOV0rvy6gp4uNRgOe+A01hXIPwUAn8r0rk5ciIJmboVx4yhjAqNHHExnldRo22Kujc1f1vZKd5OsKnchkE6k2ZKG3KX3eIS9p3fBNu/OXQY71dMWSNpNKL4lUAF4QJLq3gXDdL3Q9kk56ENmmDP0x9LNRiOLzgwNKAR82AvwRqDMaJpmYRn3L+HBqoFhEzyFRi0Ecb8dFKrQBl9TGIzvN/pXxgGX+SHxXVE+xS0NcnmGEbBbww6RYmZwukN0fndpUWo6jBzEKEmx5JYXVPSnd+wtq1P+butO1+NWeoFsak5R05vRG3MUwEojwqFT6QfT/gBje6qi1eWafext4FtvwbjwjsvD0XgsZq7rhy+zRuLwO1sphl6i0wQ29Yc1Ws1pucR1wT8aHD4l/DsQaoxs03MwQIgatB3hAhGQr4f32HEQJEnLTz2xCxf+5XZdUklsmUMhQMpmsOr6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(136003)(366004)(38100700002)(122000001)(2616005)(921005)(5660300002)(83380400001)(186003)(8936002)(7416002)(66946007)(38070700005)(66476007)(66556008)(64756008)(66446008)(2906002)(44832011)(41300700001)(6486002)(478600001)(6506007)(26005)(966005)(6512007)(110136005)(53546011)(316002)(31686004)(71200400001)(76116006)(8676002)(86362001)(91956017)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmdIdDk5aGFpdXh3VURLRUo4M096c3hJZ2I0aVFpUlBmRno0Ym1iUHBHNUxV?=
 =?utf-8?B?eEJiU2g4N2VkLzBPT0RLbUFrdmUzdjVXUmlBZHpTd3BvYmNxUFF3dk5DUUhK?=
 =?utf-8?B?QUlQaTREVmVYckpDcEZYTkF1WVZaN0VGZFZhRHRqaHBkL3pmaFNTd3J3cGtJ?=
 =?utf-8?B?ZVVxeUJxL3d1RUJLMkJYcDk5NXcrQm1qOUVPaGVkQnp3b01rL2pGV20zZmV6?=
 =?utf-8?B?d1M3VEVQNWtLL0VsQ21FdVdoZkJKZXZtRzF6aktUaHkrUTVZSFoydWd3a0NH?=
 =?utf-8?B?V29TTktER2RWLzI4NFdocUQ4VWQwVzlzbVFKTVdMSWYyOC9KbEdpVGYzZFFk?=
 =?utf-8?B?RWRISXNaQk9kSUVwRmUwWjQ1aGFmK1RKM3pUSGpEWEluakwyUHphblFQRlpT?=
 =?utf-8?B?WnNtV0U4a0o1UHh1NUhxUGFhTFJicGRpaEpoZUZCWDJvUkhZd1NNcUlzQUZa?=
 =?utf-8?B?elhCcHV5RENBcnFrNmp2V0s3TWZWU2JuSkJybENKQmdPMW41eGlLM2FIV3NI?=
 =?utf-8?B?bXNCeDdJUjNoOEh1Nmx3TkR2d0VBQW80S3M2MnRpYVpGVU1rQjNacTBLL3dS?=
 =?utf-8?B?MThGc2F2TlRtcTBobWF0a0dXM3BJYVhRc2NSaGptc21zMklGTFhrLzNkNmJo?=
 =?utf-8?B?Q3drRnNBWkVIdndiT3I3djBKKzhCZzlReHA2aFllZ1o0ODhtZHpXeE1TQzB2?=
 =?utf-8?B?N1lhZDBLVHU1VlIvMnpBQXc4RUxWSHd6L3JJZmdPNXlhN2ZEU051eldmNWNa?=
 =?utf-8?B?ZjQ4LzFqMjRtVXJIM3dGb0tOSnZybWJ4aE9MZEttcjdKVE4yNm0xbHd2Z09w?=
 =?utf-8?B?TkNtYk0vUkpkN29wNmx1WlIzdFNieUdsMFhXV3AzOHE5T2RJN2dQOEhiNzZO?=
 =?utf-8?B?a0wwVnY3SjJLZ252Mm12UEJ6VXVxeFpUaGdXSVUyVG5zci9icFpBSlJRSzRW?=
 =?utf-8?B?R3RTZWYyYzNQWFByQ1FySTJ3N2NsaVFNL2JldzVaaHJHb214VnVMWm1PNGNs?=
 =?utf-8?B?NFdPVHlhQWFaNWhkcDJ5YkpQampwM2o5QVpqNm1oREdTb2ZRTkREeDZkR21L?=
 =?utf-8?B?eEJrZWNhSDNYS3ZvNTE3eWg2VTB4Z3RVZU1HTzV4ZnFMa0t4QWtiNVdEVGpr?=
 =?utf-8?B?YTB6eHZlVktqM2xPc1hMTTJ4K3JmeENvemJpaUhBT0dyU0lzZDJQU2M0OXls?=
 =?utf-8?B?K0dJc2JXVVJWbW1kOFJjaXBGT3RIam1YNkV2SzhOR3Z4bkJiS0tmcUQ3Uzli?=
 =?utf-8?B?OEc4R29WbWtJelZ2Wm9ER1ZCV2ZMdURnQ0hjUVhzclFBSmdXSmgwZFZlbGhX?=
 =?utf-8?B?d0EwckRUY0FwdFdZZDF1TkZyTXU5SHVmYmZTODZNNFB4OURXa2EwbWJOLytL?=
 =?utf-8?B?QmQ5MjAyWXJ5NWREOWZ4ZzZKRllrSm05NUFRdTAyZmVBZFJFSXRMbmh2NThN?=
 =?utf-8?B?alNoSVNkcFV5Nmo3bDV6WUUzZk15RzF6eklaY1lYcTE1SGoxT2pjaGphc0dh?=
 =?utf-8?B?eldCUWcrR3Z0cHZ4elB6UDdaa0F3YWFVZFdleVhMYVpJZmNxUmtMK3EwaTJU?=
 =?utf-8?B?VDlwSWtrbHRBa2dDc3JyUDJ5c1JGV3pta1J5cEorajl3anRNK0Z3aVVMWjR2?=
 =?utf-8?B?dzhoR25Cckk1N09NSlNuYmtQQzhkQ0NzNUkzRXA2Und3Wm4xVWlCTnUvdXJT?=
 =?utf-8?B?Qlh5MXd0YjgrbkJuUGp2Y2wzVTNjTDh5Y3ZEcWkyeU91N1ZNYlNWQ3FmK0lR?=
 =?utf-8?B?QlBTbTJwL2JLbytMc0NmMjhXR0xaYUxTYWtkMU5kVWxtbzZXTmdESjNtdzJm?=
 =?utf-8?B?SnJmWWtiTXpMNTErSmhJMmZrR2hQZHRuQlJraC9BS200L0o5N0hWaHZDR0dO?=
 =?utf-8?B?dk9ZWlkxNzhCc0VIRkkzVk90MVB1MjZURnpxL05oK1c1S1d0M1dQcTRqc0p2?=
 =?utf-8?B?cytEMWpoeklxUUcvZ3gySHUyS2hiaERTVFR3VnRKS1BjRmRJRnZ0K3ZTSnFN?=
 =?utf-8?B?R3M5LzFEUllhTE9JREQva1gzK3hEbnBERDA4MkhBWVdQM0ZWVDhnYWxTc1Bp?=
 =?utf-8?B?dnNrYm9WRDdLaVFJSWV4bUEva3VWR0NudnFRMzEyWTMrdUlCL0RHOC8yUGZD?=
 =?utf-8?Q?skEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <978671E88CE1FF488B3B02F3E5A340C0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b7e2d-909c-4c7e-f8c4-08da70066f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 19:30:16.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXCfY5sMB1/ZrxC7xhqOg8IODMAPJ8b25g+VQPVbcLFe+1cvpaenTU4qMfuggNvRXNugHVPGfslhb+BzmFLw3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270083
X-Proofpoint-ORIG-GUID: KXoju-c5HVst4r0oGqNkj1nVt6vkRAYQ
X-Proofpoint-GUID: KXoju-c5HVst4r0oGqNkj1nVt6vkRAYQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gNy8yNy8yMDIyIDEyOjI0IFBNLCBKYW5lIENodSB3cm90ZToNCj4gT24gNy8yNy8yMDIyIDEx
OjU2IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+PiBKYW5lIENodSB3cm90ZToNCj4+PiBXaXRo
IENvbW1pdCA3OTE3ZjljZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNlLT5taXNjIHRvIGRl
dGVybWluZQ0KPj4+IHBvaXNvbiBncmFudWxhcml0eSIpIHRoYXQgY2hhbmdlZCBuZml0X2hhbmRs
ZV9tY2UoKSBjYWxsYmFjayB0byByZXBvcnQNCj4+PiBiYWRyYW5nZSBhY2NvcmRpbmcgdG8gMVVM
TCA8PCBNQ0lfTUlTQ19BRERSX0xTQihtY2UtPm1pc2MpLCBpdCdzIGJlZW4NCj4+PiBkaXNjb3Zl
cmVkIHRoYXQgdGhlIG1jZS0+bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSBp
bmplY3RpbmcNCj4+PiAyIGJhY2stdG8tYmFjayBwb2lzb25zIGFuZCB0aGUgZHJpdmVyIGVuZHMg
dXAgbG9nZ2luZyA4IGJhZGJsb2NrcywNCj4+PiBiZWNhdXNlIDB4MTAwMCBieXRlcyBpcyA4IDUx
Mi1ieXRlLg0KPj4+DQo+Pj4gRGFuIFdpbGxpYW1zIG5vdGljZWQgdGhhdCBhcGVpX21jZV9yZXBv
cnRfbWVtX2Vycm9yKCkgaGFyZGNvZGUNCj4+PiB0aGUgTFNCIGZpZWxkIHRvIFBBR0VfU0hJRlQg
aW5zdGVhZCBvZiBjb25zdWx0aW5nIHRoZSBpbnB1dA0KPj4+IHN0cnVjdCBjcGVyX3NlY19tZW1f
ZXJyIHJlY29yZC7CoCBTbyBjaGFuZ2UgdG8gcmVseSBvbiBoYXJkd2FyZSB3aGVuZXZlcg0KPj4+
IHN1cHBvcnQgaXMgYXZhaWxhYmxlLg0KPj4+DQo+Pj4gTGluazogDQo+Pj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci83ZWQ1MGZkOC01MjFlLWNhZGUtNzdiMS03MzhiOGJmYjg1MDJAb3JhY2xl
LmNvbSANCj4+Pg0KPj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1IDxqYW5lLmNodUBv
cmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWku
YyB8IDE0ICsrKysrKysrKysrKystDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L21jZS9hcGVpLmMgDQo+Pj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMN
Cj4+PiBpbmRleCA3MTcxOTI5MTVmMjguLjI2ZDYzODE4YjJkZSAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hcGVpLmMNCj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9hcGVpLmMNCj4+PiBAQCAtMjksMTUgKzI5LDI3IEBADQo+Pj4gwqAgdm9pZCBhcGVp
X21jZV9yZXBvcnRfbWVtX2Vycm9yKGludCBzZXZlcml0eSwgc3RydWN0IA0KPj4+IGNwZXJfc2Vj
X21lbV9lcnIgKm1lbV9lcnIpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKgwqAgc3RydWN0IG1jZSBt
Ow0KPj4+ICvCoMKgwqAgaW50IGdyYWluID0gUEFHRV9TSElGVDsNCj4+PiDCoMKgwqDCoMKgIGlm
ICghKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1BBKSkNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4+ICvCoMKgwqAgLyoNCj4+PiArwqDCoMKgwqAg
KiBFdmVuIGlmIHRoZSAtPnZhbGlkYXRpb25fYml0cyBhcmUgc2V0IGZvciBhZGRyZXNzIG1hc2ss
DQo+Pj4gK8KgwqDCoMKgICogdG8gYmUgZXh0cmEgc2FmZSwgY2hlY2sgYW5kIHJlamVjdCBhbiBl
cnJvciByYWRpdXMgJzAnLA0KPj4+ICvCoMKgwqDCoCAqIGFuZCBmYWxsYmFjayB0byB0aGUgZGVm
YXVsdCBwYWdlIHNpemUuDQo+Pj4gK8KgwqDCoMKgICovDQo+Pj4gK8KgwqDCoCBpZiAobWVtX2Vy
ci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURfUEFfTUFTSykgew0KPj4+ICvCoMKg
wqDCoMKgwqDCoCBncmFpbiA9IH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sgKyAxOw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoZ3JhaW4gPT0gMSkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBncmFpbiA9IFBBR0VfU0hJRlQ7DQo+Pg0KPj4gV2FpdCwgaWYgQGdyYWluIGlzIHRoZSBu
dW1iZXIgb2YgYml0cyB0byBtYXNrIG9mZiB0aGUgYWRkcmVzcywgc2hvdWxkbid0DQo+PiB0aGlz
IGJlIHNvbWV0aGluZyBsaWtlOg0KPj4NCj4+IMKgwqDCoMKgIGdyYWluID0gbWluX25vdF96ZXJv
KFBBR0VfU0hJRlQsIA0KPj4gaHdlaWdodDY0KH5tZW1fZXJyLT5waHlzaWNhbF9hZGRyX21hc2sp
KTsNCj4gDQo+IEkgc2VlLiBJIGd1ZXNzIHdoYXQgeW91IG1lYW50IGlzDQo+ICDCoMKgIGdyYWlu
ID0gbWluKFBBR0VfU0hJRlQsICgxICsgaHdlaWdodDY0KH5tZW1fZXJyLT5waHlzaWNhbF9hZGRy
X21hc2spKSk7DQoNClNvcnJ5LCB0YWtlIHRoYXQgYmFjaywgaXQgd29uJ3Qgd29yayBlaXRoZXIu
DQoNCi1qYW5lDQoNCj4gc28gdGhhdCBpbiB0aGUgcG1lbSBwb2lzb24gY2FzZSwgJ2dyYWluJyB3
b3VsZCBiZSA4LCBub3QgNy4NCj4gDQo+IHRoYW5rcywNCj4gLWphbmUNCj4gDQo+Pg0KPj4gLi4u
Pw0KPiANCg0K
